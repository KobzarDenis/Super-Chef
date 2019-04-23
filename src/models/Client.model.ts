import { Column, Model, Table, BelongsToMany, HasMany } from "sequelize-typescript";
import { Discount } from "./Discount.model";
import { ClientDiscount } from "./ClientDiscount.model";
import { Order } from "./Order.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "clients",
  schema: "service"
})
export class Client extends Model<Client> {

  @Column
  public phoneNumber: string;

  @Column
  public email: string;

  @Column
  public firstName: string;

  @Column
  public lastName: string;

  @BelongsToMany(() => Discount, () => ClientDiscount)
  public discounts: Discount[];

  @HasMany(() => Order)
  public orders: Order[];
}
