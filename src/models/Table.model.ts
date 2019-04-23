import { Column, DataType, HasMany, Model, Table } from "sequelize-typescript";
import { Order } from "./Order.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "tables",
  schema: "service"
})
export class SeatTable extends Model<SeatTable> {
  @Column
  public seatCount: number;

  @Column({
    type: DataType.ENUM(['free', 'reserved', 'busy'])
  })
  public status: string;

  @HasMany(() => Order)
  public orders: Order[];
}
