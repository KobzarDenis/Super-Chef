import { BelongsTo, Column, ForeignKey, HasMany, Model, Table } from "sequelize-typescript";
import { FoodGroup } from "./FoodGroup.model";
import { FoodIngredient } from "./FoodIngredient.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "foods",
  schema: "service"
})
export class Food extends Model<Food> {
  @ForeignKey(() => FoodGroup)
  @Column
  public groupId: number;

  @Column
  public name: string;

  @Column
  public description: string;

  @Column
  public price: number;

  @BelongsTo(() => FoodGroup)
  public foodGroup: FoodGroup[];

  @HasMany(() => FoodIngredient)
  public foodIngredients: FoodIngredient[];
}
