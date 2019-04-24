import { DiscountGroup } from "./DiscountGroup.model";
import { BelongsTo, Column, ForeignKey, HasMany, Model, Table } from "sequelize-typescript";
import { ServiceOrder } from "./ServiceOrder.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "discounts",
  schema: "service"
})
export class Discount extends Model<Discount> {
  @ForeignKey(() => DiscountGroup)
  @Column
  public groupId: number;

  @Column
  public code: string;

  @Column
  public description: string;

  @Column
  public count: number;

  @Column
  public accumulativeBonuses: number;

  @Column
  public startDate: Date;

  @Column
  public endDate: Date;

  @BelongsTo(() => DiscountGroup)
  public discountGroup: DiscountGroup[];

  @HasMany(() => ServiceOrder)
  public orders: ServiceOrder[];
}
