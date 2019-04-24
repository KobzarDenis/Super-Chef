import { Column, HasMany, Model, Table } from "sequelize-typescript";
import { StockOrder } from "./StockOrder.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "productOrderStatus",
  schema: "stock"
})
export class ProductOrderStatus extends Model<ProductOrderStatus> {
  @Column
  public name: string;

  @HasMany(() => StockOrder)
  public orders: StockOrder[];
}
