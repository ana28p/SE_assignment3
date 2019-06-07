
CREATE TABLE gm_libreoffice.`temp` (
  `id` int(11) NOT NULL,
  `f_fileName` varchar(512) DEFAULT NULL,
  `f_linesInserted` int(11) DEFAULT NULL,
  `f_linesDeleted` int(11) DEFAULT NULL,
  `f_revisionId` int(11) DEFAULT NULL,
  `f_source` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into gm_libreoffice.temp (id,f_fileName,f_linesInserted, f_linesDeleted, f_revisionId, f_source)
select id, f_fileName, f_linesInserted, f_linesDeleted, f_revisionId, 0 from gm_libreoffice.t_file where f_fileName not like '%/source/%' and f_fileName not like '%/src/%';

insert into gm_libreoffice.temp (id,f_fileName,f_linesInserted, f_linesDeleted, f_revisionId, f_source)
select id, f_fileName, f_linesInserted, f_linesDeleted, f_revisionId, 1 from gm_libreoffice.t_file where f_fileName like '%/source/%' or f_fileName like '%/src/%';

select result1.c1 as change_id, result1.review_time, result1.ecosystem_tenure, result1.changes, result1.review_tenure, result1.reviews, 
	result1.added_lines, result1.removed_lines, result1.no_files, result1.sources,
	DATEDIFF(result1.updatedTime,result2.first_label) as blocking_tenure, result2.blocking_activity from
		(select 
		c.id as c1, 
        c.ch_updatedTime as updatedTime,
        DATEDIFF(c.ch_updatedTime, min(r.rev_committedTime)) as review_time,
        DATEDIFF(c.ch_updatedTime, min(r.rev_createdTime)) as ecosystem_tenure,
        count(r.id) as changes,
        DATEDIFF(c.ch_updatedTime, min(h.hist_createdTime)) as review_tenure,
        count(h.id) as reviews,
		SUM(f.f_linesInserted) as added_lines, 
        SUM(f.f_linesDeleted) as removed_lines, 
        count(f.id) as no_files,
        (sum(f.f_source) > 0) as sources
        from gm_libreoffice.temp as f, gm_libreoffice.t_revision as r, gm_libreoffice.t_change as c, gm_libreoffice.t_history as h 
        where r.rev_changeId = c.id and r.id = f.f_revisionId and h.hist_changeId = c.id
        group by c.id) as result1
		,
        (SELECT c.id as c2, min(h.hist_createdTime) as first_label, count(h.id) as blocking_activity 
		FROM gm_libreoffice.t_history as h, gm_libreoffice.t_change as c
		WHERE h.hist_changeId = c.id and (h.hist_message LIKE '%Code-Review-2%' OR hist_message LIKE '%Code-Review+2%')
		group by c.id) as result2
        
        where result1.c1 = result2.c2;