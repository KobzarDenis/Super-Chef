import { Column, Model, Table, ForeignKey, BelongsTo } from "sequelize-typescript";
import { TransactionType } from "./TransactionType.model";
import { TransactionStatus } from "./TransactionStatus.model";
import { Employee } from "./Employee.model";
import { Account } from "./Account.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "outcomes",
  schema: "bookkeeping"
})
export class Outcome extends Model<Outcome> {
  @ForeignKey(() => TransactionType)
  @Column
  public outcomeType: number;

  @ForeignKey(() => TransactionStatus)
  @Column
  public status: number;

  @ForeignKey(() => Employee)
  @Column
  public employeeId: number;

  @ForeignKey(() => Account)
  @Column
  public accountId: number;

  @Column
  public transactionId: string;

  @Column
  public description: string;

  @Column
  public amount: number;

  @Column
  public timestamp: Date;

  @BelongsTo(() => Employee)
  public employee: Employee;

  @BelongsTo(() => Account)
  public account: Account;

  @BelongsTo(() => TransactionStatus)
  public transactionStatus: TransactionStatus;

  @BelongsTo(() => TransactionType)
  public transactionType: TransactionType;
}
