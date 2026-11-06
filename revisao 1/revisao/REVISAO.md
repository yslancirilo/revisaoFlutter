# REVISAO.md

## Resultados dos Testes

| Teste | Resultado |
|---|---|
| Cadastrar material com nome formado apenas por espaços | Bloqueado com mensagem "Este campo é obrigatório." |
| Informar quantidade negativa | Bloqueado com mensagem "A quantidade não pode ser negativa." |
| Informar quantidade com casas decimais (ex: 1.5) | Bloqueado com mensagem "Informe um número inteiro válido (sem letras ou decimais)." |
| Cadastrar dois materiais e verificar listagem | Ambos aparecem automaticamente na lista após o cadastro |
| Editar um material e recarregar a página | Os dados alterados permanecem salvos |
| Cancelar uma exclusão | O registro permanece na lista |
| Excluir um material | Somente o material selecionado é removido; os demais continuam cadastrados |
| Material com quantidade zero (ex: Extensão) | Situação exibida: "Sem estoque" |
| Material com quantidade abaixo do mínimo (ex: Cabo HDMI: 2 disponíveis, mínimo 3) | Situação exibida: "Estoque baixo" |
| Material com quantidade igual ao mínimo (ex: Caixa de som: 3 disponíveis, mínimo 1) | Situação exibida: "Estoque adequado" |
| Quantidade zero e mínimo zero | Situação exibida: "Sem estoque" |

---

## Validação Escolhida para Explicação

**Validação:** `Validadores.quantidade`

**Arquivo:** `lib/utils/validadores.dart`, método estático `quantidade`.

**Como funciona:**
- Rejeita valor nulo ou vazio.
- Usa `int.tryParse` para tentar converter o texto em inteiro. Se retornar `null`, o valor contém letras, decimais ou qualquer caractere inválido — e a mensagem de erro é retornada.
- Verifica se o número é negativo e rejeita com mensagem específica.
- Só retorna `null` (sem erro) quando o valor é um inteiro maior ou igual a zero.

**Por que esse local é adequado:**

A classe `Validadores` em `lib/utils/` é dedicada exclusivamente a regras de validação de entrada, sem dependência de interface ou banco de dados. Isso segue o princípio de responsabilidade única: a lógica de validação fica isolada, podendo ser reutilizada tanto na camada de apresentação (formulários) quanto na ViewModel, que também chama os validadores antes de persistir os dados. Centralizar as regras nesse arquivo evita duplicação e facilita manutenção — qualquer ajuste na regra de quantidade precisa ser feito em um único lugar.
