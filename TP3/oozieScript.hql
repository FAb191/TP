INSERT OVERWRITE DIRECTORY 'TP3/oozie/output'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
select prenom, count(*) as cnt from tp3.elus_municipaux group by prenom ORDER BY cnt DESC limit 100;
