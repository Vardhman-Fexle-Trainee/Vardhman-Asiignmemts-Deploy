public class StudentGroupSet {
    
    public static void studentSetOperation(){

        Set<Integer> studentSet1 = new Set<Integer>();
        studentSet1.add(1);
        studentSet1.add(3);
        studentSet1.add(5);
        Set<Integer> studentSet2 = new Set<Integer>();
        studentSet2.add(1);
        studentSet2.add(2);
        studentSet2.add(4);    
        
        // Union of studentset1 and studnetSet2
        Set<Integer> unionOfSet = new Set<Integer>();
        unionOfSet.addAll(studentSet1);
        unionOfSet.addAll(studentSet2);
        System.debug('Union :-' + unionOfSet);
        
        // Intersection of studentset1 and studnetSet2
        Set<Integer> intersectionOfSet = new Set<Integer>(studentSet1);
        intersectionOfSet.retainAll(studentSet2);
		System.debug('Intersection :-' + intersectionOfSet);
        
        // Diffrence of studentset1 and studnetSet2
        Set<Integer> diffrenceAB = new Set<Integer>(studentSet1);
        diffrenceAB.removeAll(studentSet2);
		System.debug('DiffrenceAB :-' + diffrenceAB);
        
        Set<Integer> diffrenceBA = new Set<Integer>(studentSet2);
        diffrenceBA.removeAll(studentSet1);

    }
}