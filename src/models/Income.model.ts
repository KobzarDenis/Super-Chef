import { Column, Model, Table, ForeignKey } from "sequelize-typescript";
import { TransactionType } from "./TransactionType.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "incomes",
  schema: "bookkeeping"
})
export class Income extends Model<Income> {
  @ForeignKey(() => TransactionType)
  @Column
  public incomeType: number;

  @Column
  public transactionId: string;

  @Column
  public description: string;

  @Column
  public amount: number;

  @Column
  public timestamp: Date;
}
