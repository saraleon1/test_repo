# If necessary, uncomment the line below to include explore_source.
# include: "sara_ramp_model.model.lkml"

view: pdt_sme_test {
  derived_table: {
    explore_source: order_items {
      column: sum_sale {}
      column: state { field: users.state }
    }
  }
  dimension: sum_sale {
    type: number
  }
  dimension: state {}
}
