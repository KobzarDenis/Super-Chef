import { Column,BelongsToMany,HasMany, Model, Table } from "sequelize-typescript";
import { FoodIngredient } from "./FoodIngredient.model";
import { Food } from "./Food.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "ingredients",
  schema: "service"
})
export class Ingredient extends Model<Ingredient> {
  @Column
  public name: string;

  @BelongsToMany(() => Food, () => FoodIngredient)
  public foods: Food[];

  @HasMany(() => FoodIngredient)
  public foodIngredients: FoodIngredient[];
}
