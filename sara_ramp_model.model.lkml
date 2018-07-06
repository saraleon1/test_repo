connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: sara_ramp_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: four_hour_cache {
  max_cache_age: "4 hours"

}

persist_with: sara_ramp_model_default_datagroup

explore: events {
  persist_with: four_hour_cache

  join: users {
    type: left_outer
    from: events
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: users2 {
    type: left_outer
    from:  events
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }




}

explore: inventory_items {
  always_filter: {
    filters: {
      field: created_year
      value: "2017"
    }
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  sql_always_where: ${created_date} >= '2015-01-06' ;;
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  label: "different"


}

explore: schema_migrations {}

explore: user_data {

  fields: [
    ALL_FIELDS*,
    - user_data.max_num_orders
  ]

  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: orders {
    type: left_outer
    relationship: one_to_many
    sql: ${users.id} = ${orders.user_id} ;;
  }

}

explore: users {}

explore: users_nn {}

# x At least three Explores. Amongst the three, there should be:
# x An Explore that is cached for 4 hours (hint: read about datagroups! (hint 2: persist_with:))
# x A join that uses the 'fields' parameter
# x An Explore that uses the 'always_filter' parameter
# x An Explore that uses the 'sql_always_where' parameter
# x A join that uses the 'view_label' parameter
# x A join that is an INNER join
# x A view that is joined into the same Explore twice
# x One dimension of each of the following types
# x  Number, case, string, tier, zipcode, yesno
# x  One measure of each of the following types
# x  Min, max, average, sum, sum_distinct
# x  At least one filtered measure
# x A measure that references multiple measures in its definition <- what does this mean???
# x A dimension/measure that references a field from another view - allowed as long as the join is defined in the model
#  A drill path for every measure, and    a couple dimensions (maybe a tier / location).
#  Labels and descriptions for at least 5 custom fields (fields that were not built by the generator)
#  At least 2 User Defined dashboards
#  Each dashboard should have at least 2 global filters
# Together, the dashboards should contain at least one of every available visualization type
#  One LookML dashboard
# x Value formats name for:
# x A percentage dimension/measure
# x A dollar amount dimension/measure
