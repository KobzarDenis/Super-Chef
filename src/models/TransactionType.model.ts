import { Column, HasMany, Model, Table } from "sequelize-typescript";
import { Outcome } from "./Outcome.model";
import { Income } from "./Income.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "transactionTypes",
  schema: "bookkeeping"
})
export class TransactionType extends Model<TransactionType> {
  @Column
  public name: string;

  @Column
  public description: string;

  @HasMany(() => Outcome)
  public outcomes: Outcome[];

  @HasMany(() => Income)
  public incomes: Income[];
}
