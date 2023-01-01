@echo on
REM Please adjust CUP_HOME to suit your needs
REM (please do not add a trailing backslash)

set CUP_HOME=C:\Users\Jelena\Documents\faks\5. semestar\Programski prevodioci\TudjmanFranjo\src\main\java\org\CUP-master\CUP
set CUP_VERSION=11b
set PARSER_CLASS_NAME = "FranjoParser"
set CUP_SPEC_NAME = "franjo.cup"

java -Xmx128m -jar "%CUP_HOME%\lib\java-cup-%CUP_VERSION%.jar" %*