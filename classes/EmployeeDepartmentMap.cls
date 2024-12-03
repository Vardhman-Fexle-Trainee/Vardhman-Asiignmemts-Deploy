public class EmployeeDepartmentMap {
    public void createAndPrintMap() {
    
        Map<String, List<String>> employeeByDepartment = new Map<String, List<String>>();

        
     employeeByDepartment.put('Sales', new List<String>{'Vardhman', 'Arpit', 'Nitab'});
     employeeByDepartment.put('Accounts', new List<String>{'Tom', 'Mark', 'Charles'});
     employeeByDepartment.put('Development', new List<String>{'Ramesh', 'Suresh', 'Kamlesh'});

        for (String department : employeeByDepartment.keySet()) {
            System.debug('Department: ' + department + ', Employees: ' + employeeByDepartment.get(department));
        }
    }
}