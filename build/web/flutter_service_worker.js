'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"index.html": "430ea0f394498faff4e0a0d95e609952",
"/": "430ea0f394498faff4e0a0d95e609952",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "3a669ee4e767e4a0acf1236eed9c74cd",
"assets/assets/chat_ia/u_sign.png": "3a24bbe57c718138cebfd8b60b9e5cfe",
"assets/assets/chat_ia/culpa_sign.png": "b1e81f08563578e6da543baa36f4e011",
"assets/assets/chat_ia/3_sign.png": "52f4f4054fd93dc12ca9cb2c15849c0b",
"assets/assets/chat_ia/celos_sign.png": "5467fd35ce14328a9df496034f681f14",
"assets/assets/chat_ia/enero_sign.png": "847d4382470ac90aa5249384ce5258f1",
"assets/assets/chat_ia/c_sign.png": "85f58e8563c6d8e7de2a54fa6824d9e2",
"assets/assets/chat_ia/nosotros_sign.png": "b8435749f0b1f0e6f9b2e58a0e268137",
"assets/assets/chat_ia/donde_estudias_sign.png": "9d4a13f23311220c75feb1caa7f28943",
"assets/assets/chat_ia/s_sign.png": "229fcd94e7db45ea436446b3902674ef",
"assets/assets/chat_ia/buenos_dias_sign.png": "ae1d4ee517b348a49c4f70bc4045eea3",
"assets/assets/chat_ia/0_sign.png": "f73288623cc3a5b7c8bcc7ffaee31d70",
"assets/assets/chat_ia/octubre_sign.png": "75c02a76cdf6e5f0371f9d2c21693cf5",
"assets/assets/chat_ia/mayo_sign.png": "edeb18b92f435d05c94a69970cdbfefe",
"assets/assets/chat_ia/5_sign.png": "4ba54d1e72ded5a7e556f4b796bad2e4",
"assets/assets/chat_ia/si_sign.png": "49cd2d698be68a58272252e55e3cdd17",
"assets/assets/chat_ia/miercoles_sign.png": "f1eef2461ca337c0866195d8e8838f5b",
"assets/assets/chat_ia/egoista_sign.png": "737b67ed0c1c8e4ac0fbe2833b8c8eff",
"assets/assets/chat_ia/atento_sign.png": "c3bae3c884dfc14dc33635f8855ab429",
"assets/assets/chat_ia/simpatico_sign.png": "575b2001633374ed47eb93fc5491ca3c",
"assets/assets/chat_ia/m_sign.png": "3ed89ce4eb5ebc148669916e88c30178",
"assets/assets/chat_ia/domingo_sign.png": "a145609a06a22c027f913cf3f73bd2ea",
"assets/assets/chat_ia/i_sign.png": "9a0943a9985a63a4a1b51e269ca06e9f",
"assets/assets/chat_ia/f_sign.png": "620a75673f5cadd7e7ddcdc81402bdbe",
"assets/assets/chat_ia/triste_sign.png": "592aff5af38eb3fb0225dbbcbf9d9784",
"assets/assets/chat_ia/d_sign.png": "8f75beee2dd3a3ed79e3332baced5585",
"assets/assets/chat_ia/y_sign.png": "4025a2f16bca2c65606083858a88e049",
"assets/assets/chat_ia/10_sign.png": "094a07b3dbf8a14ba8aec97b44ff25ef",
"assets/assets/chat_ia/julio_sign.png": "55a5f0c2aea85106007b1c017a14efd3",
"assets/assets/chat_ia/k_sign.png": "32eb097cec7d474598cdf856ff690d21",
"assets/assets/chat_ia/viernes_sign.png": "9b29217fa81c1ae64c5abca329bdde0d",
"assets/assets/chat_ia/bien_sign.png": "87d137257b9f27418da221916c7c8a59",
"assets/assets/chat_ia/alegre_sign.png": "9db2412ee584b36615efa9fccccc6043",
"assets/assets/chat_ia/eres_sordo_sign.png": "03ea5076eccd6ed000cf6233e94c8c71",
"assets/assets/chat_ia/w_sign.png": "3ac132f8032d02d58d60e66ffc31dad7",
"assets/assets/chat_ia/o_sign.png": "30f9059ec77584f148ef0ebcfc1b0a04",
"assets/assets/chat_ia/ustedes_sign.png": "e8984f6f4e96bb104c12e7fc9c3b2e5a",
"assets/assets/chat_ia/p_sign.png": "08918872d3ae3666f5a1291ee2b3cd19",
"assets/assets/chat_ia/martes_sign.png": "42a9564a1f4b172f4838cf14f119fe1b",
"assets/assets/chat_ia/septiembre_sign.png": "b880a409864f48e8f2efffafad7e5706",
"assets/assets/chat_ia/sufrir_sign.png": "4b41c2d1deac0f66413bee323e3d4ab3",
"assets/assets/chat_ia/yo_vivo_sign.png": "cdaa62114b631ac1f96800673a5f16c3",
"assets/assets/chat_ia/diciembre_sign.png": "b5979238bf7d781902031a86a0c4f0a3",
"assets/assets/chat_ia/q_sign.png": "e89f2e2a54bca46923638874a448794b",
"assets/assets/chat_ia/x_sign.png": "7806b9262f144fd9a54079c6802ee1ca",
"assets/assets/chat_ia/usted_sign.png": "cc9f206844ef17c3f1cf248eb80627ff",
"assets/assets/chat_ia/a_sign.png": "a6146132ff838130334e70712b4ca641",
"assets/assets/chat_ia/chao_sign.png": "f3d4716769a03681d57d7c2662570a99",
"assets/assets/chat_ia/nombre_sign.png": "ede5aa6f80fe4255de175af494de75d8",
"assets/assets/chat_ia/6_sign.png": "82581daeda26cfe0fc3682ae7f3948dd",
"assets/assets/chat_ia/8_sign.png": "70539a1f799b35e4cf2a51e943ed9bc6",
"assets/assets/chat_ia/lunes_sign.png": "5453f0724d2bc957ceefe8225f722a4b",
"assets/assets/chat_ia/amable_sign.png": "a5e0bf4e019b050c1168e19ab06e8065",
"assets/assets/chat_ia/nostalgia_sign.png": "39e59dd3c4260ff708698c658cad94ac",
"assets/assets/chat_ia/agosto_sign.png": "9b3bf5dc91e301680bfbedea9be7eb4a",
"assets/assets/chat_ia/noviembre_sign.png": "b194938e4ecd39e2faafdffe17dc1193",
"assets/assets/chat_ia/tu_sign.png": "0b8ef9c8a6bd275c3a83fe9ee92a9193",
"assets/assets/chat_ia/l_sign.png": "e8c8965ad230e24a2b5748f5ee7dc770",
"assets/assets/chat_ia/9_sign.png": "a76ce1c2e09b88a6ab6466c1bf68c711",
"assets/assets/chat_ia/abril_sign.png": "70653afdaa5951cdafc51f05aebf4e49",
"assets/assets/chat_ia/e_sign.png": "3eac997ba660cbd141fa0fb7a2308690",
"assets/assets/chat_ia/2_sign.png": "dc9e866453fbaa344119a3fa67dfe6d0",
"assets/assets/chat_ia/7_sign.png": "d5c3c45063b2bfa2eade22c07bf0bb54",
"assets/assets/chat_ia/ellos_ellas_sign.png": "32bed30919eee9fb1a9d9b7488c0e83e",
"assets/assets/chat_ia/feliz_sign.png": "9a68ee01575caee4e55278267ef51568",
"assets/assets/chat_ia/jueves_sign.png": "4ce94046113a1831aa5f787512639d96",
"assets/assets/chat_ia/donde_vives_sign.png": "d74fc6bd96d6f088c4e03f2dd7fa6227",
"assets/assets/chat_ia/g_sign.png": "d5cd168411015890036516f7f83b506d",
"assets/assets/chat_ia/b_sign.png": "7c8c578646ec285b753583ab29128d5a",
"assets/assets/chat_ia/sabado_sign.png": "9d6dc7c6fc1f2d25a71a117fe98168b5",
"assets/assets/chat_ia/yo_sign.png": "9c0e66b644a5e66d39d67496ad59b34c",
"assets/assets/chat_ia/h_sign.png": "fb98008047e8c5b846a607376bec65b8",
"assets/assets/chat_ia/marzo_sign.png": "f374278f0b5314f5f19fb3930278c8f2",
"assets/assets/chat_ia/hola_sign.png": "a7d3277a36d02e7bfff0158fd8cb7515",
"assets/assets/chat_ia/v_sign.png": "163630d735f85516f4a944e74157bb2b",
"assets/assets/chat_ia/buenas_tardes_sign.png": "aabc7df4f43094cf0cab69135b7ee463",
"assets/assets/chat_ia/n_sign.png": "519ef4573bca226cb0073a478d4a1031",
"assets/assets/chat_ia/t_sign.png": "4c1068e144e3fc273048dcd5ab34cb21",
"assets/assets/chat_ia/%25C3%25B1_sign.png": "a91ff7a3531db02badb0b200e82bc729",
"assets/assets/chat_ia/j_sign.png": "10429f4be1d6b2fd0926b2a1f2067052",
"assets/assets/chat_ia/no_sign.png": "8ea75dbfeec526662e170e14d66d3a18",
"assets/assets/chat_ia/1_sign.png": "dea0653f31d43449c23b928e1d47569c",
"assets/assets/chat_ia/el_ella_sign.png": "0d7397bc1b8e5e9a7044048f8378e372",
"assets/assets/chat_ia/febrero_sign.png": "aeeef78289c93c336c6230d935e1d015",
"assets/assets/chat_ia/yo_estudio_sign.png": "72508e7bdff1386547b0fb16b68b1de1",
"assets/assets/chat_ia/amor_sign.png": "c4dd2ad1b0b5f3c0b068e8fef0c42767",
"assets/assets/chat_ia/junio_sign.png": "aed7d65b04f9a486d4a08fe2eb4e2eed",
"assets/assets/chat_ia/r_sign.png": "d17d63fdfc9021bea276a2a80355ef3e",
"assets/assets/chat_ia/cuantos_a%25C3%25B1os_tienes_sign.png": "5e7519c275247f8e394e65e92c4f0a25",
"assets/assets/chat_ia/4_sign.png": "1e0cb8d757d9c8e1dc08d67f69c2b140",
"assets/assets/chat_ia/z_sign.png": "99d12f9d53f7764502c68dbbc2588749",
"assets/assets/chat_ia/eres_oyente_sign.png": "f62cf3777bd441a09e2a39e7d3b7566f",
"assets/assets/meses/enero_sign.png": "847d4382470ac90aa5249384ce5258f1",
"assets/assets/meses/octubre_sign.png": "75c02a76cdf6e5f0371f9d2c21693cf5",
"assets/assets/meses/mayo_sign.png": "edeb18b92f435d05c94a69970cdbfefe",
"assets/assets/meses/julio_sign.png": "55a5f0c2aea85106007b1c017a14efd3",
"assets/assets/meses/septiembre_sign.png": "b880a409864f48e8f2efffafad7e5706",
"assets/assets/meses/diciembre_sign.png": "b5979238bf7d781902031a86a0c4f0a3",
"assets/assets/meses/agosto_sign.png": "9b3bf5dc91e301680bfbedea9be7eb4a",
"assets/assets/meses/noviembre_sign.png": "b194938e4ecd39e2faafdffe17dc1193",
"assets/assets/meses/abril_sign.png": "70653afdaa5951cdafc51f05aebf4e49",
"assets/assets/meses/marzo_sign.png": "f374278f0b5314f5f19fb3930278c8f2",
"assets/assets/meses/febrero_sign.png": "aeeef78289c93c336c6230d935e1d015",
"assets/assets/meses/junio_sign.png": "aed7d65b04f9a486d4a08fe2eb4e2eed",
"assets/assets/logos/numeros_sign.png": "f32880d57eb62c12af62cc4a8b19b55f",
"assets/assets/logos/animal_sign.png": "e7a01e64f27106254151b81db7439f63",
"assets/assets/logos/interrogativo_sign.png": "fce24ce804ba5cee62631bd9f368d14d",
"assets/assets/logos/logo-light.png": "71fdac2143ae72e83bc296622f31eebb",
"assets/assets/logos/calendario_sign.png": "9ec80f144724ecc8425fc45e4da7bc9e",
"assets/assets/logos/sentimientos_sign.png": "375022347b81185f8c3a1e0599098008",
"assets/assets/logos/diccionario_night.png": "08bfc61ad120edd921ed28ceda4bc548",
"assets/assets/logos/abc_sign.png": "89029733d2ea53bf01bdca9acc553ea8",
"assets/assets/logos/diccionario_background.png": "f17ff4684f5a53bb23ee3398f104fd13",
"assets/assets/logos/semana_sign.png": "58681b8e8e80972c4c7c14479549951f",
"assets/assets/logos/pronombres_sign.png": "8ec5ee274863173836e3e79a07de0576",
"assets/assets/icons/team2.png": "0990b5217651df77e26d37ed0f5470c9",
"assets/assets/icons/team5.png": "dc70ae00e3655571aca562e62e702f64",
"assets/assets/icons/Sun.png": "60c25b46a59c082257e1fddd3a487b6f",
"assets/assets/icons/team1.png": "88499c0de60218fabaf473e6c65d25c8",
"assets/assets/icons/team3.png": "ade65028566d2b0fc7804706770e5f21",
"assets/assets/icons/team4.png": "b03c4d049f6b45201d3c2ac2caea0a66",
"assets/assets/images/u_sign.png": "3a24bbe57c718138cebfd8b60b9e5cfe",
"assets/assets/images/3_sign.png": "52f4f4054fd93dc12ca9cb2c15849c0b",
"assets/assets/images/c_sign.png": "85f58e8563c6d8e7de2a54fa6824d9e2",
"assets/assets/images/s_sign.png": "229fcd94e7db45ea436446b3902674ef",
"assets/assets/images/0_sign.png": "f73288623cc3a5b7c8bcc7ffaee31d70",
"assets/assets/images/5_sign.png": "4ba54d1e72ded5a7e556f4b796bad2e4",
"assets/assets/images/m_sign.png": "3ed89ce4eb5ebc148669916e88c30178",
"assets/assets/images/logo.png": "f1eea11bd8c3ea5dd800a1bc6573eb65",
"assets/assets/images/i_sign.png": "9a0943a9985a63a4a1b51e269ca06e9f",
"assets/assets/images/f_sign.png": "620a75673f5cadd7e7ddcdc81402bdbe",
"assets/assets/images/d_sign.png": "8f75beee2dd3a3ed79e3332baced5585",
"assets/assets/images/y_sign.png": "4025a2f16bca2c65606083858a88e049",
"assets/assets/images/10_sign.png": "094a07b3dbf8a14ba8aec97b44ff25ef",
"assets/assets/images/k_sign.png": "32eb097cec7d474598cdf856ff690d21",
"assets/assets/images/w_sign.png": "3ac132f8032d02d58d60e66ffc31dad7",
"assets/assets/images/o_sign.png": "30f9059ec77584f148ef0ebcfc1b0a04",
"assets/assets/images/p_sign.png": "08918872d3ae3666f5a1291ee2b3cd19",
"assets/assets/images/q_sign.png": "e89f2e2a54bca46923638874a448794b",
"assets/assets/images/x_sign.png": "7806b9262f144fd9a54079c6802ee1ca",
"assets/assets/images/a_sign.png": "a6146132ff838130334e70712b4ca641",
"assets/assets/images/6_sign.png": "82581daeda26cfe0fc3682ae7f3948dd",
"assets/assets/images/8_sign.png": "70539a1f799b35e4cf2a51e943ed9bc6",
"assets/assets/images/chat_background_light.png": "c57dce6db81549ceca8b44fcdf60ea96",
"assets/assets/images/l_sign.png": "e8c8965ad230e24a2b5748f5ee7dc770",
"assets/assets/images/9_sign.png": "a76ce1c2e09b88a6ab6466c1bf68c711",
"assets/assets/images/e_sign.png": "3eac997ba660cbd141fa0fb7a2308690",
"assets/assets/images/2_sign.png": "dc9e866453fbaa344119a3fa67dfe6d0",
"assets/assets/images/7_sign.png": "d5c3c45063b2bfa2eade22c07bf0bb54",
"assets/assets/images/g_sign.png": "d5cd168411015890036516f7f83b506d",
"assets/assets/images/b_sign.png": "7c8c578646ec285b753583ab29128d5a",
"assets/assets/images/chat_dark.png": "92f563635bc55229bf5def71ae74fbf2",
"assets/assets/images/h_sign.png": "fb98008047e8c5b846a607376bec65b8",
"assets/assets/images/v_sign.png": "163630d735f85516f4a944e74157bb2b",
"assets/assets/images/n_sign.png": "519ef4573bca226cb0073a478d4a1031",
"assets/assets/images/land_tree_light.png": "04e5b58dec185c5de906551379e50552",
"assets/assets/images/t_sign.png": "4c1068e144e3fc273048dcd5ab34cb21",
"assets/assets/images/%25C3%25B1_sign.png": "a91ff7a3531db02badb0b200e82bc729",
"assets/assets/images/logo2.png": "a802b50c1acecc521614b7294abfc702",
"assets/assets/images/j_sign.png": "10429f4be1d6b2fd0926b2a1f2067052",
"assets/assets/images/1_sign.png": "dea0653f31d43449c23b928e1d47569c",
"assets/assets/images/r_sign.png": "d17d63fdfc9021bea276a2a80355ef3e",
"assets/assets/images/4_sign.png": "1e0cb8d757d9c8e1dc08d67f69c2b140",
"assets/assets/images/z_sign.png": "99d12f9d53f7764502c68dbbc2588749",
"assets/assets/icons_users/user11.png": "242ff6832b7ae4b63615793b1d67e54b",
"assets/assets/icons_users/user5.png": "f087ebfc93844412a390baaf28ac2555",
"assets/assets/icons_users/user2.png": "7acff2a4bab53ebf284b817f4209cd91",
"assets/assets/icons_users/user7.png": "bc841a07000852731a734fd46efbce97",
"assets/assets/icons_users/user9.png": "75dc2bd2d8fa8a461bb32f6da9fed438",
"assets/assets/icons_users/user10.png": "dc1bcece73dedab8467fc1a6e272ec35",
"assets/assets/icons_users/user4.png": "97ba064ea193652724ab50e6b23e2baa",
"assets/assets/icons_users/user12.png": "4283c36d336ca9378e8e64c3969b2ea7",
"assets/assets/icons_users/user3.png": "63bf445e05fff91cc499da0ff6fb2193",
"assets/assets/icons_users/user8.png": "88ad83660f583cc088ad57e636fbe33c",
"assets/assets/icons_users/user6.png": "a9b34ed581bfca987252b03b7b2844c0",
"assets/assets/icons_users/user1.png": "033d06367b75f253968548baf82520d9",
"assets/assets/dias_semana/miercoles_sign.png": "f1eef2461ca337c0866195d8e8838f5b",
"assets/assets/dias_semana/domingo_sign.png": "a145609a06a22c027f913cf3f73bd2ea",
"assets/assets/dias_semana/viernes_sign.png": "9b29217fa81c1ae64c5abca329bdde0d",
"assets/assets/dias_semana/martes_sign.png": "42a9564a1f4b172f4838cf14f119fe1b",
"assets/assets/dias_semana/lunes_sign.png": "5453f0724d2bc957ceefe8225f722a4b",
"assets/assets/dias_semana/jueves_sign.png": "4ce94046113a1831aa5f787512639d96",
"assets/assets/dias_semana/sabado_sign.png": "9d6dc7c6fc1f2d25a71a117fe98168b5",
"assets/assets/sentimientos/culpa_sign.png": "b1e81f08563578e6da543baa36f4e011",
"assets/assets/sentimientos/celos_sign.png": "5467fd35ce14328a9df496034f681f14",
"assets/assets/sentimientos/egoista_sign.png": "737b67ed0c1c8e4ac0fbe2833b8c8eff",
"assets/assets/sentimientos/atento_sign.png": "c3bae3c884dfc14dc33635f8855ab429",
"assets/assets/sentimientos/simpatico_sign.png": "575b2001633374ed47eb93fc5491ca3c",
"assets/assets/sentimientos/triste_sign.png": "592aff5af38eb3fb0225dbbcbf9d9784",
"assets/assets/sentimientos/alegre_sign.png": "9db2412ee584b36615efa9fccccc6043",
"assets/assets/sentimientos/sufrir_sign.png": "4b41c2d1deac0f66413bee323e3d4ab3",
"assets/assets/sentimientos/amable_sign.png": "a5e0bf4e019b050c1168e19ab06e8065",
"assets/assets/sentimientos/nostalgia_sign.png": "39e59dd3c4260ff708698c658cad94ac",
"assets/assets/sentimientos/feliz_sign.png": "9a68ee01575caee4e55278267ef51568",
"assets/assets/sentimientos/amor_sign.png": "c4dd2ad1b0b5f3c0b068e8fef0c42767",
"assets/assets/interrogativos/con_quien_sign.png": "229db8d03e1411835865cceefb41a1b4",
"assets/assets/interrogativos/con_que_sign.png": "9c4f01af2db1d8925d1583a756979503",
"assets/assets/interrogativos/para_quien_sign.png": "652164310c4bdc78925f38ee509531ba",
"assets/assets/interrogativos/cuando_sign.png": "cd35ee84270398a3358ff2751873b56d",
"assets/assets/interrogativos/de_que_sign.png": "d028bdf9805c4e89f80364b02433ee75",
"assets/assets/interrogativos/cuantos_sign.png": "5d3bc9bc22f7bd926ea614d6dd42315f",
"assets/assets/interrogativos/donde_sign.png": "60c3868941d9124a09b2b3e1809dbae9",
"assets/assets/interrogativos/quien_sign.png": "b68fff0f3ef0098ab9c5490cd03af51b",
"assets/assets/interrogativos/cuanto_tiempo_sign.png": "4bc58428a28cdbf96962d826b2e34da4",
"assets/assets/pronombres/nosotros_sign.png": "b8435749f0b1f0e6f9b2e58a0e268137",
"assets/assets/pronombres/ustedes_sign.png": "e8984f6f4e96bb104c12e7fc9c3b2e5a",
"assets/assets/pronombres/usted_sign.png": "cc9f206844ef17c3f1cf248eb80627ff",
"assets/assets/pronombres/tu_sign.png": "0b8ef9c8a6bd275c3a83fe9ee92a9193",
"assets/assets/pronombres/ellos_ellas_sign.png": "32bed30919eee9fb1a9d9b7488c0e83e",
"assets/assets/pronombres/yo_sign.png": "9c0e66b644a5e66d39d67496ad59b34c",
"assets/assets/pronombres/el_ella_sign.png": "0d7397bc1b8e5e9a7044048f8378e372",
"assets/assets/animales/gallina_sign.png": "0671a9cd81de2363c8704675360a17b5",
"assets/assets/animales/pescado_sign.png": "d6a83383ae4c2710807fa0da6f9752f9",
"assets/assets/animales/gato_sign.png": "e552b6937f938273860cb9baa920cd91",
"assets/assets/animales/jirafa_sign.png": "8c6d7ad0b3a3cdc7d6b555c55149fce5",
"assets/assets/animales/tigre_sign.png": "fd0c7fad95ae05b5fa7d495a31bf1d5a",
"assets/assets/animales/oso_sign.png": "15e50903be911ea98e1f9adbd30eb090",
"assets/assets/animales/gallo_sign.png": "1ded0eaf556eacf99098cd83fd8f8594",
"assets/assets/animales/serpiente_sign.png": "6fc76ee919feac4475d9d55f152bbad6",
"assets/assets/animales/mono_sign.png": "ad9c83426346b11845cfda5a9dadb2a1",
"assets/assets/animales/perro_sign.png": "76efbd6f41733706f31cd18ee2548d05",
"assets/assets/animales/ara%25C3%25B1a_sign.png": "b484e81d002fbc3f654598e72574a2dc",
"assets/assets/animales/leon_sign.png": "1333e5f89dc34b1d1e1de3cabdacb8c5",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "d79abad9d8213690ad1d9a37e89b1ab9",
"assets/AssetManifest.bin.json": "f7fda7ffb093c7d2d964407f110fb382",
"assets/AssetManifest.json": "fcf58809f99e940520ae9cd775eb5100",
"assets/NOTICES": "020f1584c6a5ba4dd7c1607c68fe6dbb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "56128fc6ec7568b99d6fc24cfa34a218",
"flutter_bootstrap.js": "cd9cd9b52454e17c0dc41abeeb175862",
"main.dart.js": "42b7ed66edf2038efa574e83cb3ea99f",
"version.json": "389a6e6e6f34312743ca5f36467c84b5",
"flutter.js": "f393d3c16b631f36852323de8e583132"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
