# bar
bar graph from data file

uses: title-80.sh in other project, or use your own title display

bar.awk        in a script: cat lib.dat | bar.awk
               command line: bar.awk < lib.dat
               columns are auto-sized
               numbers auto-formatted to 4 significant digits
                  0.1234 1.234 12.34 123.4 1234
               time
                  converted to decimal
                     9:30 -> 9.50
                  can use seconds
                     9:30:48 -> 9.51

bar-lib.dat    sample data files
               see data file comments for usage
               comments & blank lines are ignored
               text fields may be left blank
               can use time numbers, 9:30
bar-test.dat
