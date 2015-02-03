module EmployeesHelper
	def manager_collection(employee)
		subordinate_ids = Employee.all_subordinates(employee).map(&:id) << employee.id.to_i
    Employee.without_ids(subordinate_ids).map{ |e| [e.full_name, e.id]}
	end
end
