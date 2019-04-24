import { BelongsTo, Column, ForeignKey, HasMany, Model, Table } from "sequelize-typescript";
import { ProductGroup } from "./ProductGroup.model";
import { ProductApplying } from "./ProductApplying.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "products",
  schema: "stock"
})
export class Product extends Model<Product> {
  @ForeignKey(() => ProductGroup)
  @Column
  public groupId: number;

  @Column
  public name: string;

  @Column
  public code: string;

  @Column
  public rest: number;

  @Column
  public price: number;

  @BelongsTo(() => ProductGroup)
  public productGroup: ProductGroup[];

  @HasMany(() => ProductApplying)
  public applyings: ProductApplying[];
}
