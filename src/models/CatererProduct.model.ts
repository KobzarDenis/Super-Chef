import { BelongsTo, Column, ForeignKey, Model, Table } from "sequelize-typescript";
import { Caterer } from "./Caterer.model";
import { Product } from "./Product.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "catererProducts",
  schema: "stock"
})
export class CatererProduct extends Model<CatererProduct> {
  @ForeignKey(() => Caterer)
  @Column
  public catererId: number;

  @ForeignKey(() => Product)
  @Column
  public productId: number;

  @BelongsTo(() => Caterer)
  public caterer: Caterer;

  @BelongsTo(() => Product)
  public product: Product;
}
