import { Discount } from "./Discount.model";
import { Column, HasMany, Model, Table } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "discountGroups",
  schema: "service"
})
export class DiscountGroup extends Model<DiscountGroup> {
  @Column
  public name: string;

  @HasMany(() => Discount, { onDelete: "cascade", hooks: true })
  public discounts: Discount[];
}
