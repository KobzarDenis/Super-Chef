import { Product } from "./Product.model";
import { Column, Model, ForeignKey, Table, BelongsTo } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "productApplying",
  schema: "stock"
})
export class ProductApplying extends Model<ProductApplying> {
  @ForeignKey(() => Product)
  @Column
  public productId: number;

  @Column
  public count: number;

  @Column
  public date: Date;

  @BelongsTo(() => Product)
  public product: Product[];
}
