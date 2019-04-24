import { Product } from "./Product.model";
import { Column, HasMany, Model, Table } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "productGroups",
  schema: "stock"
})
export class ProductGroup extends Model<ProductGroup> {
  @Column
  public name: string;

  @HasMany(() => Product)
  public products: Product[];
}
