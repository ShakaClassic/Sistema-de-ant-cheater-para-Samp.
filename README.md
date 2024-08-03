# Sistema-de-ant-cheater-para-Samp.
Sistema de ant-cheater para Samp com sistema de salvamento de dados e em breve console em Web, contém o básico dês ant god mod até o ant VPN, além disso usa uma If de Admin da rcon para evitar bugs no sistema como aplicar kick a admins e etc, ou seja o sistema até agora está escasso de bugs.

### Descrição Detalhada do Sistema ShakaByte-BOT

O **ShakaByte-BOT** é um filterscript para SA-MP que oferece um conjunto robusto de funcionalidades para garantir a integridade do jogo, monitorar e gerenciar jogadores e manter um ambiente justo no servidor. A seguir, estão os principais recursos e funções incluídos neste sistema:

#### 1. **Salvamento de Informações dos Jogadores**
- **Objetivo:** Registrar e salvar informações detalhadas de um jogador quando ele é kickado do servidor.
- **Informações Salvas:**
  - **ID do Jogador:** Identificador único do jogador.
  - **Nome do Jogador:** Nome exibido do jogador.
  - **Skin Usada:** Identificador da skin do jogador no momento do kick.
  - **Score:** Pontuação atual do jogador.
  - **PING:** Latência de conexão do jogador.
  - **Vida:** Quantidade de saúde do jogador no momento do kick.
  - **Armadura:** Quantidade de armadura do jogador.
  - **Posição:** Coordenadas X, Y e Z da posição do jogador no mapa.
  - **Velocidade:** Velocidade do jogador em cada direção.
  - **Taxa de Acertos:** Necessário ajustar a implementação para capturar a taxa de acertos.
  - **FPS:** Frames por segundo do jogo (necessário ajustar a implementação para captura).
  - **Altura:** Altura do jogador no mapa.
  - **Armas na Mão:** Lista de armas que o jogador estava segurando.
  - **Dano Causado por Segundo:** Necessário ajustar a implementação para capturar.

  Essas informações são salvas em um arquivo `.ini` específico para cada jogador, localizado no diretório `players/`.

#### 2. **Proteção Contra Cheaters**
- **Objetivo:** Identificar e kickar jogadores que tentam trapacear ou violar regras do servidor.
- **Checagens Incluídas:**
  - **Vida Acima do Permitido:** Verifica se a saúde do jogador excede o limite permitido (400.0). Se exceder, o jogador é kickado.
  - **Velocidade Excessiva:** Verifica se a velocidade do jogador está acima do limite definido (400.0 em qualquer direção). Se exceder, o jogador é kickado.
  - **Altura Inválida:** Verifica se a altura do jogador está fora do intervalo permitido (-50.0 a 2000.0). Se estiver fora, o jogador é kickado.
  - **Mudança Repentina de Score:** Verifica se o score do jogador muda abruptamente (mais de 10 pontos). Se mudar, o jogador é kickado.
  - **Mortes Rápidas:** Monitora o tempo entre mortes para garantir que um jogador não mate mais de 10 jogadores em 15 segundos. Se isso acontecer, o jogador é kickado.
  - **Uso de Armas Inválidas:** Verifica se o jogador está usando armas fora do intervalo permitido. Se estiver, o jogador é kickado.
  - **Dano Excessivo:** Verifica se o jogador causa dano acima do limite permitido (100.0). Se causar, o jogador é kickado.

#### 3. **Verificação de VPN/Proxy**
- **Objetivo:** Prevenir o uso de VPNs ou proxies para evitar detecção.
- **Método:** Checa o IP do jogador ao conectar e compara com IPs típicos de VPNs ou proxies. Se detectado, o jogador é desconectado.

#### 4. **Funções de Inicialização e Atualização**
- **OnFilterScriptInit:** Mensagens de inicialização exibidas quando o filtro script é carregado.
- **OnPlayerConnect:** Mensagens enviadas ao jogador quando ele se conecta ao servidor. Inclui verificação de VPN/Proxy.
- **OnPlayerSpawn:** Armazena o score inicial do jogador quando ele respawn.
- **OnPlayerUpdate:** Atualiza e verifica a integridade dos dados do jogador em cada atualização de jogo.
- **OnPlayerGiveDamage:** Verifica a validade das armas e o dano causado pelos jogadores.
- **OnPlayerDeath:** Registra mortes e monitora a frequência para possíveis abusos.

#### 5. **Função de Kick**
- **Objetivo:** Kicar um jogador do servidor e salvar as informações relevantes no arquivo `.ini`.
- **Método:** A função `KickPlayer` chama `SavePlayerInfo` para registrar os dados do jogador antes de kická-lo.

### Observações Adicionais
- Algumas funcionalidades, como captura de FPS e taxa de acertos, podem necessitar de implementação adicional.
- Certifique-se de que a biblioteca `dini` está instalada e configurada corretamente para o salvamento dos arquivos.

Este sistema proporciona um controle abrangente e uma camada adicional de segurança para gerenciar jogadores e evitar trapaceiros em seu servidor SA-MP.
