view: pdt_sme_test {
  derived_table: {
    explore_source: order_items {
      column: user_id { field: orders.user_id }
      column: state { field: users.state }
      column: sum_sale {}
    }
  }
  dimension: user_id {
    type: number
  }
  dimension: state {}

  dimension: sum_sale {
    type: number
  }
}
