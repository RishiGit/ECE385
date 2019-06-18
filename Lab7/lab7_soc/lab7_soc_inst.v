	lab7_soc u0 (
		.clk_clk                                    (<connected-to-clk_clk>),                                    //                                 clk.clk
		.reset_reset_n                              (<connected-to-reset_reset_n>),                              //                               reset.reset_n
		.reset_wire_export                          (<connected-to-reset_wire_export>),                          //                          reset_wire.export
		.sdram_clk_clk                              (<connected-to-sdram_clk_clk>),                              //                           sdram_clk.clk
		.sdram_wire_addr                            (<connected-to-sdram_wire_addr>),                            //                          sdram_wire.addr
		.sdram_wire_ba                              (<connected-to-sdram_wire_ba>),                              //                                    .ba
		.sdram_wire_cas_n                           (<connected-to-sdram_wire_cas_n>),                           //                                    .cas_n
		.sdram_wire_cke                             (<connected-to-sdram_wire_cke>),                             //                                    .cke
		.sdram_wire_cs_n                            (<connected-to-sdram_wire_cs_n>),                            //                                    .cs_n
		.sdram_wire_dq                              (<connected-to-sdram_wire_dq>),                              //                                    .dq
		.sdram_wire_dqm                             (<connected-to-sdram_wire_dqm>),                             //                                    .dqm
		.sdram_wire_ras_n                           (<connected-to-sdram_wire_ras_n>),                           //                                    .ras_n
		.sdram_wire_we_n                            (<connected-to-sdram_wire_we_n>),                            //                                    .we_n
		.otg_hpi_reset_external_connection_export   (<connected-to-otg_hpi_reset_external_connection_export>),   //   otg_hpi_reset_external_connection.export
		.otg_hpi_cs_external_connection_export      (<connected-to-otg_hpi_cs_external_connection_export>),      //      otg_hpi_cs_external_connection.export
		.otg_hpi_w_external_connection_export       (<connected-to-otg_hpi_w_external_connection_export>),       //       otg_hpi_w_external_connection.export
		.otg_hpi_r_external_connection_export       (<connected-to-otg_hpi_r_external_connection_export>),       //       otg_hpi_r_external_connection.export
		.otg_hpi_data_external_connection_in_port   (<connected-to-otg_hpi_data_external_connection_in_port>),   //    otg_hpi_data_external_connection.in_port
		.otg_hpi_data_external_connection_out_port  (<connected-to-otg_hpi_data_external_connection_out_port>),  //                                    .out_port
		.otg_hpi_address_external_connection_export (<connected-to-otg_hpi_address_external_connection_export>), // otg_hpi_address_external_connection.export
		.keycode_external_connection_export         (<connected-to-keycode_external_connection_export>)          //         keycode_external_connection.export
	);

