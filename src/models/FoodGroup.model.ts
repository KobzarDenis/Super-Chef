import { Food } from "./Food.model";
import { Column, HasMany, Model, Table } from "sequelize-typescript";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "foodGroups",
  schema: "service"
})
export class FoodGroup extends Model<FoodGroup> {
  @Column
  public name: string;

  @HasMany(() => Food)
  public foods: Food[];
}
