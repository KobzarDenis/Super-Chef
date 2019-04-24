import { BelongsTo, Column, DataType, ForeignKey, Model, Table } from "sequelize-typescript";
import { Account } from "./Account.model";

@Table({
  timestamps: true,
  freezeTableName: true,
  tableName: "caterers",
  schema: "stock"
})
export class Caterer extends Model<Caterer> {
  @ForeignKey(() => Account)
  @Column
  public accountId: number;

  @Column
  public name: string;

  @Column
  public code: string;

  @Column
  public address: string;

  @Column
  public phoneNumber: string;

  @Column
  public email: string;

  @Column
  public site: string;

  @Column({
    type: DataType.ENUM(['active', 'inactive']),
    defaultValue: 'active'
  })
  public status: string;

  @Column
  public createdAt: Date;

  @Column
  public updatedAt: Date;

  @Column
  public deletedAt: Date;

  @BelongsTo(() => Account)
  public account: Account;
}
