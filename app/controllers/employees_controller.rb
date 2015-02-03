class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all
  end

  def show
  end

  def new
    @employee = Employee.new
    @employee.phone = Phone.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: t('helpers.notices.created')
    else
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: t('helpers.notices.updated')
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_url, notice: t('helpers.notices.destroyed')
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :manager_id, phone_attributes: [:number ])
    end
end
