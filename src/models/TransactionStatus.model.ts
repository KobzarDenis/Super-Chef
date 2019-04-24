import { Column, HasMany, Model, Table } from "sequelize-typescript";
import { Outcome } from "./Outcome.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "transactionStatuses",
  schema: "bookkeeping"
})
export class TransactionStatus extends Model<TransactionStatus> {
  @Column
  public name: string;

  @Column
  public description: string;

  @HasMany(() => Outcome)
  public outcomes: Outcome[];
}
