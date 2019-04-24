import { BelongsTo, BelongsToMany, Column, DataType, ForeignKey, Model, Table } from "sequelize-typescript";
import { Client } from "./Client.model";
import { Employee } from "./Employee.model";
import { Discount } from "./Discount.model";
import { SeatTable } from "./Table.model";
import { Food } from "./Food.model";
import { OrderFood } from "./OrderFood.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "orders",
  schema: "service"
})
export class ServiceOrder extends Model<ServiceOrder> {
  @ForeignKey(() => Client)
  @Column
  public clientId: number;

  @ForeignKey(() => Employee)
  @Column
  public employeeId: number;

  @ForeignKey(() => SeatTable)
  @Column
  public tableId: number;

  @ForeignKey(() => Discount)
  @Column
  public discountId: number;

  @Column
  public totalPrice: number;

  @Column
  public priceWithDiscount: number;

  @Column
  public tips: number;

  @Column({
    type: DataType.ENUM(['cash', 'card'])
  })
  public paymentType: string;

  @Column({
    type: DataType.ENUM(['opened', 'closed'])
  })
  public status: string;

  @Column
  public startDate: Date;

  @Column
  public endDate: Date;

  @BelongsTo(() => Client)
  public client: Client;

  @BelongsTo(() => Employee)
  public employee: Employee;

  @BelongsTo(() => Discount)
  public discount: Discount;

  @BelongsTo(() => SeatTable)
  public seatTable: SeatTable;

  @BelongsToMany(() => Food, () => OrderFood)
  public foods: Food[];

}
