public class SortList {
    public static void sorting(){
        List<Integer> listForSort = new List<Integer>();
        listForSort.add(1);
        listForSort.add(3);
        listForSort.add(5);
        listForSort.add(4);
        listForSort.add(2);
        listForSort.add(7);
        listForSort.add(9);
        listForSort.add(12);
        listForSort.add(28);
        listForSort.add(6);
        
        //listForSort.sort();
        //System.debug(listForSort);

        for(Integer i = 0 ; i<listForSort.size()-1 ; i++){
            for(Integer j = i+1 ; j<listForSort.size() ; j++){
                if( listForSort[i] > listForSort[j] ) {
                    listForSort[i] = listForSort[i] + listForSort[j]; 
                    listForSort[j] = listForSort[i] - listForSort[j];
                    listForSort[i] = listForSort[i] - listForSort[j];
                }
            }
        }
        System.debug(listForSort);

    }
}