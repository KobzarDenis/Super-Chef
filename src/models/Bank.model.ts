import { Account } from "./Account.model";
import { Column, HasMany, Model, Table } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "banks",
  schema: "bookkeeping"
})
export class Bank extends Model<Bank> {
  @Column
  public name: string;

  @Column
  public transitAccount: string;

  @Column
  public bic: string;

  @Column
  public bin: string;

  @HasMany(() => Account, { onDelete: "cascade", hooks: true })
  public accounts: Account[];
}
