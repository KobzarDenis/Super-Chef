import { BelongsTo, Column, ForeignKey, Model, Table } from "sequelize-typescript";
import { Client } from "./Client.model";
import { Employee } from "./Employee.model";
import { Discount } from "./Discount.model";
import { Product } from "./Product.model";
import { Caterer } from "./Caterer.model";
import { ProductOrderStatus } from "./ProductOrderStatus.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "orders",
  schema: "stock"
})
export class StockOrder extends Model<StockOrder> {
  @ForeignKey(() => Product)
  @Column
  public productId: number;

  @ForeignKey(() => Caterer)
  @Column
  public catererId: number;

  @ForeignKey(() => Employee)
  @Column
  public employeeId: number;

  @ForeignKey(() => ProductOrderStatus)
  @Column
  public statusId: number;

  @Column
  public invoiceNumber: string;

  @Column
  public count: number;

  @Column
  public amount: number;

  @Column
  public supplyDate: Date;

  @Column
  public orderDate: Date;

  @BelongsTo(() => Employee)
  public employee: Employee;

  @BelongsTo(() => ProductOrderStatus)
  public status: ProductOrderStatus;

}
