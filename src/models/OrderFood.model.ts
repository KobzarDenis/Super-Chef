import { Column, ForeignKey, HasMany, Model, Table } from "sequelize-typescript";
import { Food } from "./Food.model";
import { Order } from "./Order.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "orderFoods",
  schema: "service"
})
export class OrderFood extends Model<OrderFood> {
  @ForeignKey(() => Food)
  @Column
  public foodId: number;

  @ForeignKey(() => Order)
  @Column
  public orderId: number;

  @Column
  public count: number;

  @Column
  public price: number;

  @HasMany(() => Food)
  public foods: Food[];

  @HasMany(() => Order)
  public orders: Order[];
}
