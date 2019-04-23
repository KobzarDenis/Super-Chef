import { Employee } from "./Employee.model";
import { Column, HasMany, Model, Table } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "employeeRoles",
  schema: "personal"
})
export class EmployeeRole extends Model<EmployeeRole> {
  @Column
  public name: string;

  @Column
  public description: string;

  @HasMany(() => Employee, { onDelete: "cascade", hooks: true })
  public employees: Employee[];
}
