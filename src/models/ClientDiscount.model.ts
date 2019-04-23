import { Discount } from "./Discount.model";
import { Client } from "./Client.model";
import { Column, Model, Table, ForeignKey, BelongsTo } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "clientDiscounts",
  schema: "service"
})
export class ClientDiscount extends Model<ClientDiscount> {
  @ForeignKey(() => Client)
  @Column
  public clientId: number;

  @ForeignKey(() => Discount)
  @Column
  public discountId: number;

  @BelongsTo(() => Discount)
  public discount: Discount;

  @BelongsTo(() => Client)
  public client: Client;
}
