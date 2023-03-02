CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission 

if [[ -e ListExamples.java ]]
then
    echo "ListExamples Found"
else 
    echo "need file ListExamples.java"
    exit 1
fi 

cp ../TestListExamples.java ./
cp -r ../lib ./
javac -cp $CPATH *.java 2>javac-errs.txt

if [[ $? -ne 0 ]]
then 
    echo "ListExamples Compile Error"
    exit 1
fi

pwd
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > out.txt 2>&1


NUM_FAILED=`grep -o .E out.txt | wc -l`
cat out.txt

if [[ $NUM_FAILED -gt 0 ]]
then
    grep "failure:" out.txt
    exit 0
else
    echo "All tests passed."
    exit 1
fi 

