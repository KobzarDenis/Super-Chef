import { BelongsTo, Column, ForeignKey, HasMany, Model, Table } from "sequelize-typescript";
import { Food } from "./Food.model";
import { ServiceOrder } from "./ServiceOrder.model";

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

  @ForeignKey(() => ServiceOrder)
  @Column
  public orderId: number;

  @Column
  public count: number;

  @Column
  public price: number;

  @BelongsTo(() => Food)
  public food: Food;

  @BelongsTo(() => ServiceOrder)
  public order: ServiceOrder;
}
