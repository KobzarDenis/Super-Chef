import { BelongsToMany, Column, Model, Table } from "sequelize-typescript";
import { Food } from "./Food.model";
import { FoodIngredient } from "./FoodIngredient.model";

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
}
