{
  "name": "IMOBILIARIA DASHBOAR NEEMIAS V.2.2.2",
  "nodes": [
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "5d5973b8-7627-4533-bed3-1f8eb951a03e",
              "name": "event",
              "value": "={{ $json.body.event }}",
              "type": "string"
            },
            {
              "id": "751cf1b7-bfb2-48b4-8e35-494e46156335",
              "name": "instance",
              "value": "={{ $json.body.instance }}",
              "type": "string"
            },
            {
              "id": "a47f40ec-d2d5-4e85-be06-346d0cc1a261",
              "name": "remoteJid",
              "value": "={{ $json.body.data.key.remoteJid.split('@')[0].trim() }}\n\n\n",
              "type": "string"
            },
            {
              "id": "18ee8a35-8ea5-45dc-9f64-92d7eabbecd9",
              "name": "fromMe",
              "value": "={{ $json.body.data.key.fromMe }}",
              "type": "string"
            },
            {
              "id": "eeaf0983-03fa-4c3f-9960-4253af17ef75",
              "name": "pushName",
              "value": "={{ $json.body.data.pushName }}",
              "type": "string"
            },
            {
              "id": "646dff76-28d2-4dd2-ae84-0242f6e57e71",
              "name": "conversation",
              "value": "={{ $json.body.data.message.conversation }}",
              "type": "string"
            },
            {
              "id": "97ef02ac-0461-4d41-969a-0b719e863137",
              "name": "messageType",
              "value": "={{ $json.body.data.messageType }}",
              "type": "string"
            },
            {
              "id": "b1512842-de35-4cbe-9fd7-dc67bef788c9",
              "name": "timestamp",
              "value": "={{ $json.body.data.messageTimestamp }}",
              "type": "string"
            },
            {
              "id": "5b6ed7ad-8dc5-449e-b5c5-60427c66357c",
              "name": "idMensagem",
              "value": "={{ $json.body.data.key.id }}",
              "type": "string"
            },
            {
              "id": "76c7ff06-6821-4744-a018-7090f06d50a7",
              "name": "id_sessao",
              "value": "={{ $json.body.instance }}-{{ $json.body.data.key.remoteJid }}",
              "type": "string"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        448,
        768
      ],
      "id": "4a161f53-71f0-4475-84e6-28b164096f36",
      "name": "Dados"
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "={{ $json.message }}",
        "options": {
          "systemMessage": "=# Papel\n\n<papel>\nVocê é a Camila, uma atendente virtual especialista da Imobiliária Neemias 🏠🔑.\nSeu objetivo é encantar os clientes, fornecendo informações precisas sobre imóveis e facilitando o agendamento de visitas via WhatsApp.\nSempre se apresente de forma simpática e pergunte o nome do cliente.\nA data e hora atuais são: {{ $now.format('dd/MM/yyyy HH:mm') }}.\n</papel>\n\n# Contexto\n\n<contexto>\nVocê atende clientes da Imobiliária Neemias pelo WhatsApp. Seu foco é duplo:\n1.  **Consultoria de Imóveis:** Ajudar clientes a encontrar o imóvel dos sonhos usando sua ferramenta de busca.\n2.  **Agendamento de Visitas:** Marcar visitas para os imóveis que o cliente escolher.\nO único corretor disponível para visitas é o **Carlos Roberto**.\n</contexto>\n\n# Ferramentas\n\nVocê tem acesso a uma ferramenta poderosa:\n\n- **`buscar_imoveis`**: Use esta ferramenta SEMPRE que um cliente fizer uma pergunta sobre o inventário de imóveis. Ela é essencial para responder a perguntas como \"procuro casas com piscina\", \"quais apartamentos de 2 quartos você tem?\", ou \"tem algo no bairro Dirceu?\". A ferramenta busca no banco de dados e retorna uma lista de imóveis relevantes com todos os seus detalhes: descrição, preço, link do site e, mais importante, um **link da imagem principal**.\n\n# Fluxo de Interação\n\n1.  **Busca de Imóveis:** Se a intenção do cliente for encontrar um imóvel, use a ferramenta `buscar_imoveis`. Após receber os resultados, apresente-os de forma clara e atraente (veja a seção #Formato de Resposta).\n2.  **Agendamento:** Uma vez que o cliente escolha um imóvel (seja pela busca ou por já saber a referência), prossiga com o agendamento, extraindo a data e a hora desejadas.\n\n# Formato de Resposta\n\nSua resposta DEVE ser sempre um objeto JSON. A chave \"intenção\" determina o que o fluxo de trabalho fará.\n\n1.  **`intenção: \"informar_imoveis\"`**: Use esta intenção após uma busca bem-sucedida. A chave \"mensagem\" deve conter uma lista de objetos, onde cada objeto representa um imóvel encontrado.\n\n    **Exemplo de Resposta:**\n    ```json\n    {\n      \"intenção\": \"informar_imoveis\",\n      \"mensagem\": [\n        {\n          \"imagem_url\": \"https://site.com/imagem1.jpg\",\n          \"texto\": \"*Casa para Venda no bairro Dirceu*\\n*Referência:* CA619\\n*Valor:* R$ 340.000,00\\n\\nImóvel bem localizado com 3 quartos e quintal.\\n\\n*Para mais detalhes, acesse:*\\nhttps://site.com/link1\"\n        },\n        {\n          \"imagem_url\": \"https://site.com/imagem2.jpg\",\n          \"texto\": \"*Apartamento para Venda no bairro São Benedito*\\n*Referência:* SKY PARNAÍBA\\n*Valor:* R$ 286.990,00\\n\\nEmpreendimento moderno com lazer completo.\\n\\n*Para mais detalhes, acesse:*\\nhttps://site.com/link2\"\n        }\n      ]\n    }\n    ```\n\n2.  **`intenção: \"agendamento_confirmado\"`**: Use esta intenção para confirmar um agendamento.\n\n    **Exemplo de Resposta:**\n    ```json\n    {\n      \"intenção\": \"agendamento_confirmado\",\n      \"mensagem\": \"Perfeito, sua visita foi agendada!\",\n      \"data_agendamento\": \"02/10/2025\",\n      \"hora_agendamento\": \"15:00\",\n      \"codigo_imovel\": \"CA619\",\n      \"corretor\": \"Carlos Roberto\"\n    }\n    ```\n\n3.  **`intenção: \"pergunta_frequente\"`**: Para saudações, perguntas gerais ou quando nenhum imóvel for encontrado.\n    `{\"intenção\": \"pergunta_frequente\", \"mensagem\": \"Olá! Sou a Camila. Procuro um imóvel para você ou quer agendar uma visita?\"}`\n\n# Restrições\n\n- **Seja Proativa:** Sempre que a pergunta for sobre imóveis, use a ferramenta `buscar_imoveis`. Não responda \"Vou verificar\", simplesmente use a ferramenta.\n- **Formato da Apresentação:** Ao apresentar os imóveis, siga o formato da `intenção: \"informar_imoveis\"` à risca. Use os dados retornados pela ferramenta (`pageContent` e `metadata` ) para construir a resposta. Use Markdown para formatar o texto (negrito, itálico).\n- **Validação de Agendamento:** NUNCA agende horários no passado. Valide sempre a data e hora em relação a `{{ $now.format('dd/MM/yyyy HH:mm') }}`.\n"
        }
      },
      "type": "@n8n/n8n-nodes-langchain.agent",
      "typeVersion": 2.2,
      "position": [
        2144,
        688
      ],
      "id": "c38c94d1-76a6-45ae-9ccd-e4f23c784b17",
      "name": "AI Agent"
    },
    {
      "parameters": {
        "sessionIdType": "customKey",
        "sessionKey": "={{ $json[\"Mensagem de Audio\"].id_sessao }}\n",
        "sessionTTL": 3600,
        "contextWindowLength": 10
      },
      "type": "@n8n/n8n-nodes-langchain.memoryRedisChat",
      "typeVersion": 1.5,
      "position": [
        2192,
        896
      ],
      "id": "ebb45da1-cbdf-4b33-a283-43693164b248",
      "name": "Redis Chat Memory",
      "credentials": {
        "redis": {
          "id": "7vv2mdqBW1Hs6yTu",
          "name": "Redis Nando"
        }
      }
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "c7a9f891-3441-4b61-8ae5-3450bc2cb29f",
              "name": "message",
              "value": "={{ $('Dados').item.json.conversation }}",
              "type": "string"
            }
          ]
        },
        "includeOtherFields": true,
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        1328,
        672
      ],
      "id": "783fe18d-f363-4a30-b77a-b674f8f18677",
      "name": "Mensagem de Texto"
    },
    {
      "parameters": {
        "rules": {
          "values": [
            {
              "conditions": {
                "options": {
                  "caseSensitive": true,
                  "leftValue": "",
                  "typeValidation": "strict",
                  "version": 2
                },
                "conditions": [
                  {
                    "leftValue": "={{ $json.messageType }}",
                    "rightValue": "conversation",
                    "operator": {
                      "type": "string",
                      "operation": "equals"
                    },
                    "id": "cdc97e07-cc8f-4501-b948-a6afc889a09a"
                  }
                ],
                "combinator": "and"
              }
            },
            {
              "conditions": {
                "options": {
                  "caseSensitive": true,
                  "leftValue": "",
                  "typeValidation": "strict",
                  "version": 2
                },
                "conditions": [
                  {
                    "id": "0c18fa05-3022-4b6c-a848-e7e55034793f",
                    "leftValue": "={{ $json.messageType }}",
                    "rightValue": "audioMessage",
                    "operator": {
                      "type": "string",
                      "operation": "equals",
                      "name": "filter.operator.equals"
                    }
                  }
                ],
                "combinator": "and"
              }
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.switch",
      "typeVersion": 3.2,
      "position": [
        768,
        768
      ],
      "id": "520555cc-f870-4feb-93c0-274eba6ca5c3",
      "name": "Tipo de Mensagem"
    },
    {
      "parameters": {
        "resource": "chat-api",
        "operation": "get-media-base64",
        "instanceName": "={{ $json.instance }}",
        "messageId": "={{ $json.idMensagem }}"
      },
      "type": "n8n-nodes-evolution-api.evolutionApi",
      "typeVersion": 1,
      "position": [
        1008,
        848
      ],
      "id": "bbb46190-8778-42e8-a2d5-153e4364256b",
      "name": "Get Base 64",
      "credentials": {
        "evolutionApi": {
          "id": "me0DAjmPwqicVrhv",
          "name": "Evolution Secretaria"
        }
      }
    },
    {
      "parameters": {
        "operation": "toBinary",
        "sourceProperty": "data.base64",
        "options": {
          "fileName": "audio.mp3",
          "mimeType": "audio/mpeg"
        }
      },
      "type": "n8n-nodes-base.convertToFile",
      "typeVersion": 1.1,
      "position": [
        1232,
        848
      ],
      "id": "8d9c68da-bfa5-42d9-9552-48396cab5a6a",
      "name": "Audio"
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "a9b0447a-ad26-487e-b8ae-bf5b1b6d3174",
              "name": "message",
              "value": "={{ $json.text }}",
              "type": "string"
            }
          ]
        },
        "includeOtherFields": true,
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        1680,
        848
      ],
      "id": "a1bcd1d8-a07c-4889-9768-57a1393ce572",
      "name": "Mensagem de Audio"
    },
    {
      "parameters": {
        "method": "POST",
        "url": "https://api.groq.com/openai/v1/audio/transcriptions",
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "groqApi",
        "sendBody": true,
        "contentType": "multipart-form-data",
        "bodyParameters": {
          "parameters": [
            {
              "name": "model",
              "value": "whisper-large-v3-turbo"
            },
            {
              "name": "temperature",
              "value": "0"
            },
            {
              "name": "response_format",
              "value": "verbose_json"
            },
            {
              "name": "language",
              "value": "pt"
            },
            {
              "parameterType": "formBinaryData",
              "name": "file",
              "inputDataFieldName": "data"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 4.2,
      "position": [
        1456,
        848
      ],
      "id": "8881bdca-793c-452f-93f5-dbe7bb367591",
      "name": "Groq",
      "credentials": {
        "groqApi": {
          "id": "YVBFjEdN9UWannyJ",
          "name": "Groq account"
        }
      }
    },
    {
      "parameters": {
        "schemaType": "manual",
        "inputSchema": "{\n  \"type\": \"object\",\n  \"properties\": {\n    \"messages\": {\n      \"type\": \"array\",\n      \"items\": {\n        \"type\": \"string\"\n      }\n    }\n  },\n  \"required\": [\"messages\"]\n}\n"
      },
      "id": "a2a205fb-edee-47b9-8e49-f0bddcca7aa7",
      "name": "Output Parser",
      "type": "@n8n/n8n-nodes-langchain.outputParserStructured",
      "typeVersion": 1.2,
      "position": [
        6272,
        896
      ]
    },
    {
      "parameters": {
        "promptType": "define",
        "text": "=Formate e separe a seguinte mensagem: {{ $json.mensagem }}\n",
        "hasOutputParser": true,
        "messages": {
          "messageValues": [
            {
              "message": "=Sua única saída deve ser um objeto JSON no seguinte formato:\n\n{\n  \"messages\": [\n    \"Mensagem 1\",\n    \"Mensagem 2\",\n    \"Mensagem 3\"\n  ]\n}\n\n- Nunca adicione explicações, nem texto fora desse JSON.\n- Não crie a chave \"output\".\n- Se a mensagem já for curta, devolva apenas:\n{\n  \"messages\": [\"Mensagem única aqui\"]\n}\n- Nunca devolva array vazio.\n- Nunca mais de 4 mensagens.\n"
            }
          ]
        }
      },
      "type": "@n8n/n8n-nodes-langchain.chainLlm",
      "typeVersion": 1.6,
      "position": [
        6080,
        656
      ],
      "id": "f37b8c9d-e33c-4978-ba40-24be7f86999e",
      "name": "Parser"
    },
    {
      "parameters": {
        "fieldToSplitOut": "output.messages",
        "include": "allOtherFields",
        "options": {
          "destinationFieldName": "message"
        }
      },
      "type": "n8n-nodes-base.splitOut",
      "typeVersion": 1,
      "position": [
        6448,
        656
      ],
      "id": "e821f44a-b2c8-4c50-a291-b85902f98acd",
      "name": "Split Out"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "n8n-nodes-base.splitInBatches",
      "typeVersion": 3,
      "position": [
        6864,
        656
      ],
      "id": "f35783f3-d150-4129-b31f-37be46b09b1d",
      "name": "Loop Over Items"
    },
    {
      "parameters": {
        "resource": "messages-api",
        "instanceName": "={{ $('Dados').item.json.instance }}",
        "remoteJid": "={{ $('Dados').item.json.remoteJid }}",
        "messageText": "={{ $json.message }}",
        "options_message": {
          "delay": 2000,
          "linkPreview": true
        }
      },
      "type": "n8n-nodes-evolution-api.evolutionApi",
      "typeVersion": 1,
      "position": [
        7104,
        672
      ],
      "id": "f1a8d161-b1df-4b7b-a507-9d6c30f7ca2b",
      "name": "Enviar Mensagem",
      "credentials": {
        "evolutionApi": {
          "id": "me0DAjmPwqicVrhv",
          "name": "Evolution Secretaria"
        }
      }
    },
    {
      "parameters": {
        "model": {
          "__rl": true,
          "mode": "list",
          "value": "gpt-4.1-mini"
        },
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatOpenAi",
      "typeVersion": 1.2,
      "position": [
        2016,
        544
      ],
      "id": "f7750325-3c04-461a-9c71-b470265f1c8f",
      "name": "OpenAI Chat Model",
      "credentials": {
        "openAiApi": {
          "id": "Ou7FadVrQ6qGBgBU",
          "name": "OpenAi Geral 29/08"
        }
      }
    },
    {
      "parameters": {
        "jsCode": "// Obtém o output do nó anterior (AI Agent) e o transforma em um objeto JSON\nconst aiOutput = JSON.parse(items[0].json.output);\n\n// Define as variáveis como nulas por padrão\nlet dataFormatada = null;\nlet horaAgendamento = null;\nlet codigoImovel = null; // MUDANÇA: Trocamos 'servicoNome' por 'codigoImovel'\nlet corretor = \"Carlos Roberto\"; // MUDANÇA: Trocamos 'barbeiro' por 'corretor' e definimos o nome correto\n\n// Só tenta formatar os dados se a intenção for de agendamento\nif (aiOutput.intenção === 'agendamento_confirmado') {\n  // Formata a data para o padrão do Supabase (YYYY-MM-DD)\n  const dataAgendamento = aiOutput.data_agendamento;\n  const partesDaData = dataAgendamento.split('/');\n  dataFormatada = partesDaData[2] + '-' + partesDaData[1] + '-' + partesDaData[0];\n\n  // Formata a hora para o padrão do Supabase (HH:MM:SS)\n  horaAgendamento = aiOutput.hora_agendamento + ':00';\n  \n  // Obtém o código do imóvel extraído pela IA\n  codigoImovel = aiOutput.codigo_imovel; // MUDANÇA: Usamos a nova chave 'codigo_imovel'\n  \n  // A IA pode sugerir um corretor, mas vamos garantir que seja sempre 'Carlos Roberto'\n  // Se a IA retornar um nome, ele será ignorado e 'Carlos Roberto' será usado.\n  corretor = aiOutput.corretor || \"Carlos Roberto\";\n}\n\n// Retorna um novo objeto com as chaves corretas para o fluxo da imobiliária\nreturn {\n  intenção: aiOutput.intenção,\n  mensagem: aiOutput.mensagem,\n  data_agendamento: dataFormatada,\n  hora_agendamento: horaAgendamento,\n  codigo_imovel: codigoImovel, // MUDANÇA: Retornamos 'codigo_imovel'\n  corretor: corretor // MUDANÇA: Retornamos 'corretor' em vez de 'barbeiro'\n};\n\n"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        2608,
        688
      ],
      "id": "624e6e47-567d-4f10-b74a-824d0554706a",
      "name": "Code"
    },
    {
      "parameters": {
        "operation": "getAll",
        "tableId": "agendamentos",
        "filters": {
          "conditions": [
            {
              "keyName": "data_agendamento",
              "condition": "eq",
              "keyValue": "={{ $('Code').item.json.data_agendamento }}"
            },
            {
              "keyName": "funcionario",
              "condition": "eq",
              "keyValue": "={{ $('Code').item.json.barbeiro }}"
            },
            {
              "keyName": "hora_agendamento",
              "condition": "eq",
              "keyValue": "={{ $('Code').item.json.hora_agendamento }}"
            }
          ]
        }
      },
      "type": "n8n-nodes-base.supabase",
      "typeVersion": 1,
      "position": [
        3808,
        528
      ],
      "id": "01b2bc34-75b7-479b-967f-58c8ad99b9f9",
      "name": "Verificar Agenda",
      "alwaysOutputData": true,
      "credentials": {
        "supabaseApi": {
          "id": "RuIgWQmC1Z9stGp0",
          "name": "Supabase imobiliaria Neemias"
        }
      }
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "0840da47-0036-472a-a25c-b45ec39eaffe",
              "name": "mensagem ",
              "value": "Olá! Infelizmente, o horário que você escolheu já está ocupado. Por favor, tente outro horário ou consulte nossa disponibilidade.",
              "type": "string"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        5440,
        320
      ],
      "id": "3ca1da52-c3d6-4f1e-b28d-387249db6937",
      "name": "Mensagem Horário Ocupado"
    },
    {
      "parameters": {
        "conditions": {
          "options": {
            "caseSensitive": true,
            "leftValue": "",
            "typeValidation": "strict",
            "version": 2
          },
          "conditions": [
            {
              "id": "5ddb5e67-6bf9-4dd1-ab3b-ee7f10a37761",
              "leftValue": "={{ $(\"Verificar Agenda\").length }}",
              "rightValue": 0,
              "operator": {
                "type": "number",
                "operation": "gt"
              }
            },
            {
              "id": "9d9a5db0-4e81-480a-83ec-e88367768d4b",
              "leftValue": "",
              "rightValue": "",
              "operator": {
                "type": "string",
                "operation": "equals",
                "name": "filter.operator.equals"
              }
            }
          ],
          "combinator": "and"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.if",
      "typeVersion": 2.2,
      "position": [
        4064,
        528
      ],
      "id": "c0fa1e62-af25-4e09-ae0e-5b126b9ee8b5",
      "name": "Verificar Disponibilidade",
      "alwaysOutputData": false
    },
    {
      "parameters": {
        "operation": "getAll",
        "tableId": "clientes",
        "filters": {
          "conditions": [
            {
              "keyName": "telefone",
              "condition": "eq",
              "keyValue": "={{ $(\"Dados\").item.json.remoteJid }}"
            }
          ]
        }
      },
      "type": "n8n-nodes-base.supabase",
      "typeVersion": 1,
      "position": [
        4304,
        544
      ],
      "id": "214531b0-82b8-48af-af77-aba95308f568",
      "name": "Verificar Cliente",
      "alwaysOutputData": true,
      "credentials": {
        "supabaseApi": {
          "id": "RuIgWQmC1Z9stGp0",
          "name": "Supabase imobiliaria Neemias"
        }
      }
    },
    {
      "parameters": {
        "conditions": {
          "options": {
            "caseSensitive": true,
            "leftValue": "",
            "typeValidation": "strict",
            "version": 2
          },
          "conditions": [
            {
              "id": "719a7c4e-907a-4e6c-9fe7-ba7a882ce983",
              "leftValue": "={{ $(\"Verificar Cliente\").length }}",
              "rightValue": 0,
              "operator": {
                "type": "number",
                "operation": "gt"
              }
            }
          ],
          "combinator": "and"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.if",
      "typeVersion": 2.2,
      "position": [
        4544,
        544
      ],
      "id": "06301d47-a228-426a-a2af-3eb775645566",
      "name": "Cliente Existe?"
    },
    {
      "parameters": {
        "tableId": "clientes",
        "fieldsUi": {
          "fieldValues": [
            {
              "fieldId": "nome",
              "fieldValue": "={{ $(\"Dados\").item.json.pushName }}"
            },
            {
              "fieldId": "telefone",
              "fieldValue": "={{ $(\"Dados\").item.json.remoteJid }}"
            }
          ]
        }
      },
      "type": "n8n-nodes-base.supabase",
      "typeVersion": 1,
      "position": [
        4800,
        592
      ],
      "id": "8339eabe-9e8f-4b4f-aed0-fdb3760a9d63",
      "name": "Criar Cliente",
      "credentials": {
        "supabaseApi": {
          "id": "RuIgWQmC1Z9stGp0",
          "name": "Supabase imobiliaria Neemias"
        }
      }
    },
    {
      "parameters": {},
      "type": "n8n-nodes-base.merge",
      "typeVersion": 3.2,
      "position": [
        5040,
        544
      ],
      "id": "0f2e5184-959a-43d3-941e-fb7f994ea65c",
      "name": "Merge"
    },
    {
      "parameters": {
        "tableId": "agendamentos",
        "fieldsUi": {
          "fieldValues": [
            {
              "fieldId": "cliente_id",
              "fieldValue": "={{ $('Merge').item.json.id }}"
            },
            {
              "fieldId": "funcionario",
              "fieldValue": "={{ $('Buscar Corretor').item.json.id }}"
            },
            {
              "fieldId": "hora_agendamento",
              "fieldValue": "={{ $('Code').item.json.hora_agendamento }}"
            },
            {
              "fieldId": "data_agendamento",
              "fieldValue": "={{ $('Code').item.json.data_agendamento }}"
            }
          ]
        }
      },
      "type": "n8n-nodes-base.supabase",
      "typeVersion": 1,
      "position": [
        5248,
        544
      ],
      "id": "e00cb5c8-f5cf-4eab-9bcc-07802729283d",
      "name": "Agendar Horário",
      "credentials": {
        "supabaseApi": {
          "id": "RuIgWQmC1Z9stGp0",
          "name": "Supabase imobiliaria Neemias"
        }
      }
    },
    {
      "parameters": {
        "numberInputs": 3
      },
      "type": "n8n-nodes-base.merge",
      "typeVersion": 3.2,
      "position": [
        5888,
        720
      ],
      "id": "f78d2db6-2e5c-4147-b20d-dd0e2508cda1",
      "name": "Merge1"
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "d46f5dc6-f221-4db8-baea-10d0d13b0513",
              "name": "mensagem",
              "value": "={{ $('Code').item.json.mensagem }}",
              "type": "string"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        2848,
        688
      ],
      "id": "284c2858-447d-4f11-a945-8dee6339f7df",
      "name": "Mensagem Final1"
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "6f2420c6-290c-4c04-a4c9-58ac14c20a77",
              "name": "mensagem",
              "value": "=Perfeito, {{ $('Dados').item.json.pushName }}! ✅ Sua visita foi agendada com nosso corretor Carlos Roberto para o dia {{ DateTime.fromISO($('Code').item.json.data_agendamento).toFormat('dd/MM/yyyy') }} às {{ $('Code').item.json.hora_agendamento.slice(0, 5) }}.\n\nQualquer dúvida, estamos à disposição! 🏠🔑\n\n",
              "type": "string"
            },
            {
              "id": "1eb3c3ea-996c-4179-a661-d7e2abdbb8df",
              "name": "",
              "value": "",
              "type": "string"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        5440,
        544
      ],
      "id": "154da559-f4f1-49e0-80cf-012973eefcf0",
      "name": "Mensagem Final2"
    },
    {
      "parameters": {
        "model": {
          "__rl": true,
          "mode": "list",
          "value": "gpt-4.1-mini"
        },
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatOpenAi",
      "typeVersion": 1.2,
      "position": [
        6064,
        896
      ],
      "id": "21254998-681b-4d3a-ae89-0faf4a84b399",
      "name": "OpenAI Chat Model1",
      "credentials": {
        "openAiApi": {
          "id": "Ou7FadVrQ6qGBgBU",
          "name": "OpenAi Geral 29/08"
        }
      }
    },
    {
      "parameters": {},
      "type": "@n8n/n8n-nodes-langchain.toolThink",
      "typeVersion": 1.1,
      "position": [
        2448,
        896
      ],
      "id": "bb89f1f7-51b1-43e8-b6e7-82df6a17ea41",
      "name": "Think"
    },
    {
      "parameters": {
        "content": "## MENSAGEM WHATSAPP ",
        "height": 576,
        "width": 640,
        "color": 4
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        0,
        480
      ],
      "typeVersion": 1,
      "id": "68e2bc09-36f2-4315-b62b-a0d4f7a35078",
      "name": "Sticky Note"
    },
    {
      "parameters": {
        "content": "## TIPO DE MENSAGEM",
        "height": 576,
        "width": 1184
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        640,
        480
      ],
      "typeVersion": 1,
      "id": "78b2f98d-e774-477f-974e-08f5e34b8aa6",
      "name": "Sticky Note1"
    },
    {
      "parameters": {
        "content": "## AGENTE",
        "height": 576,
        "width": 720,
        "color": 3
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        1824,
        480
      ],
      "typeVersion": 1,
      "id": "4f35f912-658d-4e85-8aca-45089a7a0bcf",
      "name": "Sticky Note2"
    },
    {
      "parameters": {
        "content": "## É AGENDAMENTO ?",
        "height": 576,
        "width": 816,
        "color": 7
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        2544,
        480
      ],
      "typeVersion": 1,
      "id": "639da22d-c6e3-4752-b596-130a6dafc896",
      "name": "Sticky Note3"
    },
    {
      "parameters": {
        "content": "## DASHBOARD / HORÁRIO OCUPADO",
        "height": 800,
        "width": 2416
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        3360,
        256
      ],
      "typeVersion": 1,
      "id": "398f8d39-5ad4-44a1-bdf2-657f10ad223f",
      "name": "Sticky Note4"
    },
    {
      "parameters": {
        "content": "## DIVIDIR MENSAGEM",
        "height": 576,
        "width": 928,
        "color": 5
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        5776,
        480
      ],
      "typeVersion": 1,
      "id": "a633e056-c328-459a-b225-81fc73d35550",
      "name": "Sticky Note5"
    },
    {
      "parameters": {
        "content": "## ENVIANDO MENSAGEM",
        "height": 576,
        "width": 672,
        "color": 6
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        6640,
        480
      ],
      "typeVersion": 1,
      "id": "a6b9c992-e729-41cd-8446-4b100c3889ee",
      "name": "Sticky Note6"
    },
    {
      "parameters": {
        "content": "## DASHBOARD IMOBILIARIA\n   \n![Scraper](https://png.pngtree.com/png-vector/20230414/ourlarge/pngtree-house-logo-real-estate-housing-society-vector-png-image_6705949.png)                                        ",
        "height": 448,
        "width": 576
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        0,
        0
      ],
      "typeVersion": 1,
      "id": "588abbb9-08de-4698-9a87-237458a30dee",
      "name": "Sticky Note7"
    },
    {
      "parameters": {
        "operation": "getAll",
        "tableId": "profiles",
        "filters": {
          "conditions": [
            {
              "keyName": "full_name",
              "condition": "ilike",
              "keyValue": "={{ $('Code').item.json.corretor }}"
            }
          ]
        }
      },
      "type": "n8n-nodes-base.supabase",
      "typeVersion": 1,
      "position": [
        3536,
        528
      ],
      "id": "71d01cc0-78f7-4657-a690-8c3be3bca3bb",
      "name": "Buscar Corretor",
      "alwaysOutputData": true,
      "credentials": {
        "supabaseApi": {
          "id": "RuIgWQmC1Z9stGp0",
          "name": "Supabase imobiliaria Neemias"
        }
      }
    },
    {
      "parameters": {
        "content": "## BANCO DE DADOS RAG",
        "height": 688,
        "width": 2416,
        "color": 6
      },
      "type": "n8n-nodes-base.stickyNote",
      "position": [
        1520,
        1056
      ],
      "typeVersion": 1,
      "id": "875ff590-137a-4fdf-9212-9bd90838b61a",
      "name": "Sticky Note8"
    },
    {
      "parameters": {
        "pollTimes": {
          "item": [
            {
              "mode": "everyMinute"
            }
          ]
        },
        "triggerOn": "specificFolder",
        "folderToWatch": {
          "__rl": true,
          "value": "1mDwz148QCFDXWmn9m5KAHYN-56I91vSk",
          "mode": "list",
          "cachedResultName": "RAG_NEEMIAS_IMOBILIARIA",
          "cachedResultUrl": "https://drive.google.com/drive/folders/1mDwz148QCFDXWmn9m5KAHYN-56I91vSk"
        },
        "event": "fileCreated",
        "options": {}
      },
      "type": "n8n-nodes-base.googleDriveTrigger",
      "typeVersion": 1,
      "position": [
        1616,
        1424
      ],
      "id": "f8300148-0d13-48a2-9871-b9a09b60f85d",
      "name": "Arquivo_novo",
      "credentials": {
        "googleDriveOAuth2Api": {
          "id": "FhooX57Dj3rAOzDE",
          "name": "Google Drive Ghudu"
        }
      }
    },
    {
      "parameters": {
        "operation": "download",
        "fileId": {
          "__rl": true,
          "value": "={{ $json.file_id }}",
          "mode": "id"
        },
        "options": {
          "googleFileConversion": {
            "conversion": {
              "docsToFormat": "text/plain",
              "drawingsToFormat": "application/pdf",
              "slidesToFormat": "application/pdf"
            }
          }
        }
      },
      "type": "n8n-nodes-base.googleDrive",
      "typeVersion": 3,
      "position": [
        2096,
        1424
      ],
      "id": "52b8f45e-5e70-4a5f-a5bc-b007fa16b335",
      "name": "Download",
      "credentials": {
        "googleDriveOAuth2Api": {
          "id": "FhooX57Dj3rAOzDE",
          "name": "Google Drive Ghudu"
        }
      }
    },
    {
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "id": "45d813ce-40d4-40bc-afa3-9b7bd0ab885f",
              "name": "file_id",
              "value": "={{ $json.id }}",
              "type": "string"
            },
            {
              "id": "306998bf-3814-423a-a141-30796f0debb5",
              "name": "file_name",
              "value": "={{ $json.name }}",
              "type": "string"
            },
            {
              "id": "d6226937-4be8-43d4-9886-abc043436a81",
              "name": "file_type",
              "value": "={{ $json.mimeType }}",
              "type": "string"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.set",
      "typeVersion": 3.4,
      "position": [
        1824,
        1424
      ],
      "id": "39949973-0db2-45cd-81f4-626e187901d1",
      "name": "Dados1"
    },
    {
      "parameters": {
        "rules": {
          "values": [
            {
              "conditions": {
                "options": {
                  "caseSensitive": true,
                  "leftValue": "",
                  "typeValidation": "strict",
                  "version": 2
                },
                "conditions": [
                  {
                    "leftValue": "={{ $('Dados1').item.json.file_type }}",
                    "rightValue": "application/vnd.google-apps.spreadsheet",
                    "operator": {
                      "type": "string",
                      "operation": "equals"
                    },
                    "id": "202b5f05-9aff-4c1a-afc1-26399ed92a59"
                  }
                ],
                "combinator": "and"
              }
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.switch",
      "typeVersion": 3.3,
      "position": [
        2336,
        1424
      ],
      "id": "1c0204ba-4cf5-4234-868e-a4f716c8b1a7",
      "name": "Tipo_de_arquivo"
    },
    {
      "parameters": {
        "aggregate": "aggregateAllItemData",
        "options": {}
      },
      "type": "n8n-nodes-base.aggregate",
      "typeVersion": 1,
      "position": [
        2960,
        1152
      ],
      "id": "82a8337b-a631-451f-b09f-40e423467f41",
      "name": "Aggregate"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "n8n-nodes-base.extractFromFile",
      "typeVersion": 1,
      "position": [
        2688,
        1152
      ],
      "id": "76500f70-3b23-42bf-b135-7f4529b9d5bf",
      "name": "Extract from CSV"
    },
    {
      "parameters": {
        "fieldsToSummarize": {
          "values": [
            {
              "aggregation": "concatenate",
              "field": "data"
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.summarize",
      "typeVersion": 1.1,
      "position": [
        3184,
        1152
      ],
      "id": "46a1aac3-9418-4a81-9366-dd46449248ec",
      "name": "Summarize"
    },
    {
      "parameters": {
        "mode": "insert",
        "tableName": "imobiliaria_rag",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.vectorStorePGVector",
      "typeVersion": 1.3,
      "position": [
        3584,
        1152
      ],
      "id": "6f3f0e68-af49-4187-8b95-a2c1f6ee0a51",
      "name": "JSON Loader",
      "credentials": {
        "postgres": {
          "id": "nmpJMCSXz5m8gJlk",
          "name": "Neemias Imobiliaria"
        }
      }
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.embeddingsOpenAi",
      "typeVersion": 1.2,
      "position": [
        3472,
        1392
      ],
      "id": "af2a6119-cf0c-4961-845f-d179803bb1de",
      "name": "Embeddings OpenAI",
      "credentials": {
        "openAiApi": {
          "id": "Ou7FadVrQ6qGBgBU",
          "name": "OpenAi Geral 29/08"
        }
      }
    },
    {
      "parameters": {
        "chunkSize": 10000,
        "chunkOverlap": 200,
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.textSplitterRecursiveCharacterTextSplitter",
      "typeVersion": 1,
      "position": [
        3728,
        1568
      ],
      "id": "5ae17974-82a8-4f7d-a77e-b4a8571fc054",
      "name": "Recursive Character Text Splitter1"
    },
    {
      "parameters": {
        "textSplittingMode": "custom",
        "options": {
          "metadata": {
            "metadataValues": [
              {
                "name": "file_id",
                "value": "={{ $('Dados1').item.json.file_id }}"
              },
              {
                "name": "file_name",
                "value": "={{ $('Dados1').item.json.file_name }}"
              }
            ]
          }
        }
      },
      "type": "@n8n/n8n-nodes-langchain.documentDefaultDataLoader",
      "typeVersion": 1.1,
      "position": [
        3600,
        1376
      ],
      "id": "78f9d7b6-439d-480d-b8e5-f5e6c7a3efd6",
      "name": "Default Data Loader"
    },
    {
      "parameters": {
        "mode": "retrieve-as-tool",
        "toolDescription": "Use esta ferramenta para buscar e encontrar imóveis disponíveis no banco de dados da imobiliária. É a ferramenta principal para responder perguntas de clientes sobre o inventário de imóveis, como \"procuro casas com piscina\" ou \"quais apartamentos de 2 quartos você tem no bairro X?\". A ferramenta retorna uma lista de imóveis relevantes com todos os seus detalhes.\n",
        "tableName": "imobiliaria_rag",
        "topK": 8,
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.vectorStorePGVector",
      "typeVersion": 1.3,
      "position": [
        2272,
        1104
      ],
      "id": "22ee78c3-bc95-4bc7-b31a-380859b7f7c7",
      "name": "Postgres PGVector Store",
      "credentials": {
        "postgres": {
          "id": "nmpJMCSXz5m8gJlk",
          "name": "Neemias Imobiliaria"
        }
      }
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.embeddingsOpenAi",
      "typeVersion": 1.2,
      "position": [
        2096,
        1200
      ],
      "id": "5d00c9f1-098f-4328-a3b2-c1deec6ae3a9",
      "name": "Embeddings OpenAI1",
      "credentials": {
        "openAiApi": {
          "id": "Ou7FadVrQ6qGBgBU",
          "name": "OpenAi Geral 29/08"
        }
      }
    },
    {
      "parameters": {
        "httpMethod": "POST",
        "path": "9f3258ca-8e22-4abf-b56d-61d8f8f6d6c2",
        "options": {}
      },
      "type": "n8n-nodes-base.webhook",
      "typeVersion": 2.1,
      "position": [
        128,
        768
      ],
      "id": "08e36cf7-a919-4ce4-b656-903c26b97f68",
      "name": "Webhook",
      "webhookId": "9f3258ca-8e22-4abf-b56d-61d8f8f6d6c2"
    },
    {
      "parameters": {
        "rules": {
          "values": [
            {
              "conditions": {
                "options": {
                  "caseSensitive": true,
                  "leftValue": "",
                  "typeValidation": "strict",
                  "version": 2
                },
                "conditions": [
                  {
                    "leftValue": "={{ $('Code').item.json.intenção }}",
                    "rightValue": "agendamento_confirmado",
                    "operator": {
                      "type": "string",
                      "operation": "equals"
                    },
                    "id": "72e1af3d-ca64-49aa-904f-7aa717b89aa9"
                  }
                ],
                "combinator": "and"
              }
            },
            {
              "conditions": {
                "options": {
                  "caseSensitive": true,
                  "leftValue": "",
                  "typeValidation": "strict",
                  "version": 2
                },
                "conditions": [
                  {
                    "id": "995d46a6-ad94-44ce-ae04-a9bc9be54028",
                    "leftValue": "={{ $('Code').item.json.intenção }}",
                    "rightValue": "informar_imoveis",
                    "operator": {
                      "type": "string",
                      "operation": "equals",
                      "name": "filter.operator.equals"
                    }
                  }
                ],
                "combinator": "and"
              }
            },
            {
              "conditions": {
                "options": {
                  "caseSensitive": true,
                  "leftValue": "",
                  "typeValidation": "strict",
                  "version": 2
                },
                "conditions": [
                  {
                    "id": "66bbed8e-8d6b-4b29-8a9a-6b1548cc9e8c",
                    "leftValue": "=",
                    "rightValue": "",
                    "operator": {
                      "type": "string",
                      "operation": "equals",
                      "name": "filter.operator.equals"
                    }
                  }
                ],
                "combinator": "and"
              }
            }
          ]
        },
        "options": {}
      },
      "type": "n8n-nodes-base.switch",
      "typeVersion": 3.3,
      "position": [
        3120,
        640
      ],
      "id": "9295266c-0b5b-4e41-8d77-0118a83b9d5c",
      "name": "Switch"
    },
    {
      "parameters": {
        "jsCode": "// Pega o texto JSON da IA\nconst jsonString = $input.all()[0].json.mensagem;\n\n// Converte o texto em uma lista de objetos JavaScript\nconst imoveis = JSON.parse(jsonString);\n\n// Transforma a lista no formato que o n8n espera\nconst n8nItems = imoveis.map(imovel => {\n  return { json: imovel };\n});\n\n// Retorna a lista de itens formatada para o n8n\nreturn n8nItems;\n"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        3552,
        800
      ],
      "id": "82104a44-1a57-4969-81e3-ce8f1fcff57d",
      "name": "Parse JSON da IA"
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "n8n-nodes-base.splitInBatches",
      "typeVersion": 3,
      "position": [
        3808,
        800
      ],
      "id": "9c5906fc-a4ce-404e-8094-36816b4418b2",
      "name": "Loop Para Cada Imóvel"
    },
    {
      "parameters": {
        "resource": "messages-api",
        "operation": "send-image",
        "instanceName": "={{ $('Dados').item.json.instance }}",
        "remoteJid": "={{ $('Dados').item.json.remoteJid }}",
        "media": "={{ $json.imagem_url }}",
        "caption": "={{ $json.texto }}",
        "options_message": {}
      },
      "type": "n8n-nodes-evolution-api.evolutionApi",
      "typeVersion": 1,
      "position": [
        4800,
        864
      ],
      "id": "33f2ed7f-abc3-42c5-b5e8-5cd5d59ced45",
      "name": "Enviar Card do Imóvel",
      "credentials": {
        "evolutionApi": {
          "id": "me0DAjmPwqicVrhv",
          "name": "Evolution Secretaria"
        }
      }
    },
    {
      "parameters": {
        "resource": "messages-api",
        "instanceName": "={{ $item(\"0\").$node[\"Dados\"].json[\"instance\"] }}",
        "remoteJid": "={{ $item(\"0\").$node[\"Dados\"].json[\"remoteJid\"] }}",
        "messageText": "={{ $item(\"0\").$node[\"Finalizar Loop\"].json[\"mensagem_final\"] }}",
        "options_message": {}
      },
      "type": "n8n-nodes-evolution-api.evolutionApi",
      "typeVersion": 1,
      "position": [
        4240,
        720
      ],
      "id": "c8c7f5a8-aa3f-463f-9dca-57f38fbcb7b4",
      "name": "Call-to-Action",
      "credentials": {
        "evolutionApi": {
          "id": "me0DAjmPwqicVrhv",
          "name": "Evolution Secretaria"
        }
      }
    },
    {
      "parameters": {
        "jsCode": "// Pega os dados do cliente do início do fluxo\nconst dadosIniciais = $('Dados').item.json;\n\n// Define as partes da mensagem\nconst titulo = \"*Aqui estão os imóveis que selecionei para você!* 🏡\";\nconst corpo1 = \"A jornada para um novo lar pode parecer complexa, mas meu trabalho é torná-la simples e segura para você. O primeiro passo é visitar e ver qual deles faz seu coração bater mais forte.\";\nconst corpo2 = \"Me informe a referência do imóvel que despertou seu interesse e eu cuido de todo o agendamento da visita. Simples assim.\";\nconst fechamento = \"*Qual deles vamos conhecer primeiro?*\";\n\n// Junta tudo com quebras de linha reais\nconst mensagemFormatada = `${titulo}\\n\\n${corpo1}\\n\\n${corpo2}\\n\\n${fechamento}`;\n\n// Prepara o item final para o próximo nó\nconst itemFinal = {\n  json: {\n    mensagem_final: mensagemFormatada,\n    instance: dadosIniciais.instance,\n    remoteJid: dadosIniciais.remoteJid\n  }\n};\n\n// Retorna uma lista com apenas um item, garantindo que o próximo nó execute só uma vez\nreturn [itemFinal];\n"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        4032,
        720
      ],
      "id": "e1edcffa-4a2c-4115-8ac5-704756a6a090",
      "name": "Finalizar Loop"
    },
    {
      "parameters": {
        "model": "openai/gpt-oss-20b",
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGroq",
      "typeVersion": 1,
      "position": [
        2224,
        512
      ],
      "id": "6c100329-6802-4f31-b10b-6eaa89fb213a",
      "name": "Groq Chat Model",
      "credentials": {
        "groqApi": {
          "id": "qmhsYUy6aAaGnADg",
          "name": "Groq Ghudu"
        }
      }
    },
    {
      "parameters": {
        "options": {}
      },
      "type": "@n8n/n8n-nodes-langchain.lmChatGoogleGemini",
      "typeVersion": 1,
      "position": [
        2016,
        896
      ],
      "id": "3a7c6e71-5f25-45a1-a6b8-41767c11cc7d",
      "name": "Google Gemini Chat Model",
      "credentials": {
        "googlePalmApi": {
          "id": "hrVrZun2tDS0uqC2",
          "name": "Gemini Linda"
        }
      }
    }
  ],
  "pinData": {
    "Webhook": [
      {
        "json": {
          "headers": {
            "host": "n8n.autoia.store",
            "user-agent": "axios/1.12.2",
            "content-length": "1266",
            "accept": "application/json, text/plain, */*",
            "accept-encoding": "gzip, compress, deflate, br",
            "content-type": "application/json",
            "x-forwarded-for": "172.18.0.1",
            "x-forwarded-host": "n8n.autoia.store",
            "x-forwarded-port": "443",
            "x-forwarded-proto": "https",
            "x-forwarded-server": "73eb438f35ca",
            "x-real-ip": "172.18.0.1"
          },
          "params": {},
          "query": {},
          "body": {
            "event": "messages.upsert",
            "instance": "Secretaria",
            "data": {
              "key": {
                "remoteJid": "5521989732007@s.whatsapp.net",
                "remoteJidAlt": "238491480916058:20@lid",
                "fromMe": false,
                "id": "3FA7C7B5CEC28EA8109B"
              },
              "pushName": "Fernando",
              "status": "DELIVERY_ACK",
              "message": {
                "messageContextInfo": {
                  "deviceListMetadata": {
                    "senderKeyIndexes": [],
                    "recipientKeyIndexes": [],
                    "senderKeyHash": {
                      "0": 224,
                      "1": 84,
                      "2": 250,
                      "3": 113,
                      "4": 141,
                      "5": 82,
                      "6": 21,
                      "7": 235,
                      "8": 75,
                      "9": 137
                    },
                    "senderTimestamp": 1758774376,
                    "recipientKeyHash": {
                      "0": 129,
                      "1": 88,
                      "2": 123,
                      "3": 168,
                      "4": 67,
                      "5": 75,
                      "6": 149,
                      "7": 117,
                      "8": 165,
                      "9": 186
                    },
                    "recipientTimestamp": 1758232253
                  },
                  "deviceListMetadataVersion": 2
                },
                "conversation": "Uma casa com piscina"
              },
              "contextInfo": {
                "mentionedJid": [],
                "groupMentions": [],
                "expiration": 0,
                "ephemeralSettingTimestamp": 0,
                "disappearingMode": {
                  "initiator": 0
                }
              },
              "messageType": "conversation",
              "messageTimestamp": 1759111905,
              "instanceId": "21bcb4e4-d1b6-449b-bfe0-c63487c29005",
              "source": "desktop",
              "chatwootMessageId": 770,
              "chatwootInboxId": 8,
              "chatwootConversationId": 2
            },
            "destination": "https://n8n.autoia.store/webhook-test/9f3258ca-8e22-4abf-b56d-61d8f8f6d6c2",
            "date_time": "2025-09-28T23:11:45.488Z",
            "sender": "5521982983364@s.whatsapp.net",
            "server_url": "https://evolutionapi.autoia.store",
            "apikey": "E6DF3BDCAE02-424C-9949-86FBFD2EBC8B"
          },
          "webhookUrl": "https://n8n.autoia.store/webhook-test/9f3258ca-8e22-4abf-b56d-61d8f8f6d6c2",
          "executionMode": "test"
        }
      }
    ]
  },
  "connections": {
    "Dados": {
      "main": [
        [
          {
            "node": "Tipo de Mensagem",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "AI Agent": {
      "main": [
        [
          {
            "node": "Code",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Redis Chat Memory": {
      "ai_memory": [
        [
          {
            "node": "AI Agent",
            "type": "ai_memory",
            "index": 0
          }
        ]
      ]
    },
    "Mensagem de Texto": {
      "main": [
        [
          {
            "node": "AI Agent",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Tipo de Mensagem": {
      "main": [
        [
          {
            "node": "Mensagem de Texto",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Get Base 64",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Get Base 64": {
      "main": [
        [
          {
            "node": "Audio",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Audio": {
      "main": [
        [
          {
            "node": "Groq",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Mensagem de Audio": {
      "main": [
        [
          {
            "node": "AI Agent",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Groq": {
      "main": [
        [
          {
            "node": "Mensagem de Audio",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Output Parser": {
      "ai_outputParser": [
        [
          {
            "node": "Parser",
            "type": "ai_outputParser",
            "index": 0
          }
        ]
      ]
    },
    "Parser": {
      "main": [
        [
          {
            "node": "Split Out",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Split Out": {
      "main": [
        [
          {
            "node": "Loop Over Items",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Loop Over Items": {
      "main": [
        [],
        [
          {
            "node": "Enviar Mensagem",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Enviar Mensagem": {
      "main": [
        [
          {
            "node": "Loop Over Items",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "OpenAI Chat Model": {
      "ai_languageModel": [
        []
      ]
    },
    "Code": {
      "main": [
        [
          {
            "node": "Mensagem Final1",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Verificar Agenda": {
      "main": [
        [
          {
            "node": "Verificar Disponibilidade",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Mensagem Horário Ocupado": {
      "main": [
        [
          {
            "node": "Merge1",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Verificar Disponibilidade": {
      "main": [
        [
          {
            "node": "Mensagem Horário Ocupado",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Verificar Cliente",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Verificar Cliente": {
      "main": [
        [
          {
            "node": "Cliente Existe?",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Cliente Existe?": {
      "main": [
        [
          {
            "node": "Merge",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Criar Cliente",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Criar Cliente": {
      "main": [
        [
          {
            "node": "Merge",
            "type": "main",
            "index": 1
          }
        ]
      ]
    },
    "Merge": {
      "main": [
        [
          {
            "node": "Agendar Horário",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Agendar Horário": {
      "main": [
        [
          {
            "node": "Mensagem Final2",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Merge1": {
      "main": [
        [
          {
            "node": "Parser",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Mensagem Final1": {
      "main": [
        [
          {
            "node": "Switch",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Mensagem Final2": {
      "main": [
        [
          {
            "node": "Merge1",
            "type": "main",
            "index": 1
          }
        ]
      ]
    },
    "OpenAI Chat Model1": {
      "ai_languageModel": [
        [
          {
            "node": "Parser",
            "type": "ai_languageModel",
            "index": 0
          }
        ]
      ]
    },
    "Think": {
      "ai_tool": [
        [
          {
            "node": "AI Agent",
            "type": "ai_tool",
            "index": 0
          }
        ]
      ]
    },
    "Buscar Corretor": {
      "main": [
        [
          {
            "node": "Verificar Agenda",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Arquivo_novo": {
      "main": [
        [
          {
            "node": "Dados1",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Download": {
      "main": [
        [
          {
            "node": "Tipo_de_arquivo",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Dados1": {
      "main": [
        [
          {
            "node": "Download",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Tipo_de_arquivo": {
      "main": [
        [
          {
            "node": "Extract from CSV",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Extract from CSV": {
      "main": [
        [
          {
            "node": "Aggregate",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Aggregate": {
      "main": [
        [
          {
            "node": "Summarize",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Summarize": {
      "main": [
        [
          {
            "node": "JSON Loader",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Embeddings OpenAI": {
      "ai_embedding": [
        [
          {
            "node": "JSON Loader",
            "type": "ai_embedding",
            "index": 0
          }
        ]
      ]
    },
    "Recursive Character Text Splitter1": {
      "ai_textSplitter": [
        [
          {
            "node": "Default Data Loader",
            "type": "ai_textSplitter",
            "index": 0
          }
        ]
      ]
    },
    "Default Data Loader": {
      "ai_document": [
        [
          {
            "node": "JSON Loader",
            "type": "ai_document",
            "index": 0
          }
        ]
      ]
    },
    "Postgres PGVector Store": {
      "ai_tool": [
        [
          {
            "node": "AI Agent",
            "type": "ai_tool",
            "index": 0
          }
        ]
      ]
    },
    "Embeddings OpenAI1": {
      "ai_embedding": [
        [
          {
            "node": "Postgres PGVector Store",
            "type": "ai_embedding",
            "index": 0
          }
        ]
      ]
    },
    "Webhook": {
      "main": [
        [
          {
            "node": "Dados",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Switch": {
      "main": [
        [
          {
            "node": "Buscar Corretor",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Parse JSON da IA",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Merge1",
            "type": "main",
            "index": 2
          }
        ]
      ]
    },
    "Parse JSON da IA": {
      "main": [
        [
          {
            "node": "Loop Para Cada Imóvel",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Loop Para Cada Imóvel": {
      "main": [
        [
          {
            "node": "Finalizar Loop",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Enviar Card do Imóvel",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Enviar Card do Imóvel": {
      "main": [
        [
          {
            "node": "Loop Para Cada Imóvel",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Finalizar Loop": {
      "main": [
        [
          {
            "node": "Call-to-Action",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Groq Chat Model": {
      "ai_languageModel": [
        []
      ]
    },
    "Google Gemini Chat Model": {
      "ai_languageModel": [
        [
          {
            "node": "AI Agent",
            "type": "ai_languageModel",
            "index": 0
          }
        ]
      ]
    }
  },
  "active": false,
  "settings": {
    "executionOrder": "v1"
  },
  "versionId": "79bc72b1-857a-465e-9df7-e4392fbc6e42",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "51ec8b13dcbf144ca4f84c354a83778b0deb1106e3615dc3e4f21105dfa59e92"
  },
  "id": "gYPffAlAzBqMEVmf",
  "tags": [
    {
      "createdAt": "2025-09-28T11:04:16.694Z",
      "updatedAt": "2025-09-28T11:04:16.694Z",
      "id": "MEFOS5UO2XEgBQK8",
      "name": "imobiliaria_dashboard"
    }
  ]
}
