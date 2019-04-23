import { BelongsTo, Column, HasOne, Model, Table, ForeignKey } from "sequelize-typescript";
import { Employee } from "./Employee.model";
import { Bank } from "./Bank.model";

@Table({
  timestamps: true,
  freezeTableName: true,
  tableName: "accounts",
  schema: "bookkeeping"
})
export class Account extends Model<Account> {
  @Column
  public number: string;

  @ForeignKey(() => Bank)
  @Column
  public bankId: number;

  @Column
  public isActive: boolean;

  @Column
  public createdAt: Date;

  @Column
  public updatedAt: Date;

  @HasOne(() => Employee)
  public employee: Employee;

  @BelongsTo(() => Bank)
  public bank: Bank;
}
