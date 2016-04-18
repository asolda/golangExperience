#
# This is a UNIX shell script to do these steps:
#
#    (1) build the sym.java tokens file using cup
#    (2) build PascalLexer.java from pascal.jflex, using jflex
#    (3) compile PascalLexer.java with the test and token files
#    (4) run PascalLexer on the file(s) given as command-line arg(s)
#
# Run this script like this, for example:
#
#    .make lexer-test.p
#

#
# In the csh code below, the command-line reference to cup is based on the
# following alias.  This alias should be defined in .cshrc, but it's repeated
# here to show what it looks like.  The classpath argument refers to the CUP
# install directory, which is /Users/faculty/gfisher/pkg/cup on falcon/hornet.
#
alias cup "java -classpath .:/Users/faculty/gfisher/pkg/cup java_cup.Main <"

#
# In the csh code below, the command-line reference to jflex is based on a path
# variable setting that includes the the jflex install directory, which is
# /Users/faculty/gfisher/pkg/jflex/bin/jflex on falcon/hornet.  The path
# variable should be set in .cshrc.  Ask Fisher if you don't know how to do this.
#

#
# Here is the csh code to run steps (1) through (4) explained above:
#
cup pascal-tokens.cup                                        # Step 1
jflex pascal.jflex                                           # Step 2
javac PascalLexer.java PascalLexerTest.java sym.java         # Step 3
java PascalLexerTest $*                                      # Step 4

# The "$*" argument in Step 4 is the UNIX way to pass along all command-line
# arguments sent to this to java.  Hence, the example run above:
#
#     .make lexer-test.p
#
# compiles everything and sends the lexer-test.p file into PascalLexerTest.
#
