jflex go.jflex
java -jar java-cup-11a.jar -interface -parser Parser go.cup
javac -cp java-cup-11a.jar *.java
