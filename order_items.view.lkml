view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  measure: sum_sale {
    type: sum
    sql: ${TABLE}.sale_price ;;
  }


  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: revenue{
    type:  number
    sql:  ${products.retail_price} - ${inventory_items.cost} ;;
    value_format_name: usd
  }

  dimension: test_total_rev {
    type:  number
    sql:  SUM(${products.retail_price} - ${inventory_items.cost} ) ;;
  }

  measure: rev_percent {
    type: number
    value_format: "0.00%"
    sql:100. * ${revenue}/SUM(${revenue})  ;;
  }

measure: total_revenue {
  type: sum
  sql: ${revenue} ;;
  value_format_name: usd
}

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
}
