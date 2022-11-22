demographics.db : twentieth_day_report.csv
	csvs-to-sqlite $^ $@
	sqlite3 $@ < scripts/ever_students.sql

twentieth_day_report.csv : twentieth_day_report_wide.csv
	csvcut -c year,'School ID','School','Head Start','Other PK','State PK','PK SPED','Full-Day K','Half-Day K',K,12,13,14,15,16,17,18,19,20,21,22,23,'Total' $< | python scripts/pivot_longer.py > $@

twentieth_day_report_wide.csv : membership_20th_day_2006.csv			\
                           membership_20th_day_2007.csv			\
                           membership_20th_day_2008.csv			\
                           membership_20th_day_2009.csv			\
                           membership_20th_day_2010_updated.csv		\
                           membership_20th_day_2011.csv			\
                           membership_20th_day_2012.csv			\
                           enrollment_20th_day_2013.csv			\
                           enrollment_20th_day_2014.csv			\
                           enrollment_20th_day_2014-15.csv		\
                           enrollment_20th_day_2016_gv_20151023.csv	\
                           demographics_20thday_2017.csv		\
                           demographics_20thday_2018.csv		\
                           demographics_20thday_2019.csv		\
                           demographics_20thday_2020.csv		\
                           demographics_20thday_2021_v10072020.csv	\
                           demographics_20thday_2022_v10272021.csv	\
                           demographics_20thday_2023.csv
	csvstack -g 2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023 -n year $^ > $@

%.csv : %.xls
	in2csv $< | python scripts/harmonize_twentieth_day_headers.py > $@

demographics_20thday_2023.csv : demographics_20thday_2023.xlsx
	in2csv $< | tail -n +2 | python scripts/harmonize_twentieth_day_headers.py > $@

%.xlsx :
	wget https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/$@

%.xls :
	wget https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/$@
