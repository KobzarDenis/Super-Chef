import { EmployeeRole } from "./EmployeeRole.model";
import { BelongsTo, Column, Model, Table, DataType, ForeignKey, HasMany } from "sequelize-typescript";
import { Account } from "./Account.model";
import { ServiceOrder } from "./ServiceOrder.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "employees",
  schema: "personal"
})
export class Employee extends Model<Employee> {
  @ForeignKey(() => Account)
  @Column
  public accountId: number;

  @ForeignKey(() => EmployeeRole)
  @Column
  public roleId: number;

  @Column({
    type: DataType.ENUM('male', 'female')
  })
  public sex: string;

  @Column
  public salary: number;

  @Column
  public passportCode: string;

  @Column
  public passportSeries: string;

  @Column
  public ein: string;

  @Column
  public phoneNumber: string;

  @Column
  public email: string;

  @Column
  public firstName: string;

  @Column
  public lastName: string;

  @Column
  public address: string;

  @Column
  public offerDate: Date;

  @Column
  public fireDate: Date;

  @BelongsTo(() => EmployeeRole)
  public role: EmployeeRole;

  @BelongsTo(() => Account)
  public account: Account;

  @HasMany(() => ServiceOrder)
  public orders: ServiceOrder[];
}
