import { Column, BelongsTo, ForeignKey, Model, Table } from "sequelize-typescript";
import { Food } from "./Food.model";
import { Ingredient } from "./Ingredient.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "foodIngredients",
  schema: "service"
})
export class FoodIngredient extends Model<FoodIngredient> {
  @ForeignKey(() => Food)
  @Column
  public foodId: number;

  @ForeignKey(() => Ingredient)
  @Column
  public ingredientId: number;

  @Column
  public weight: number;

  @BelongsTo(() => Food)
  public food: Food;

  @BelongsTo(() => Ingredient)
  public ingredient: Ingredient;
}
