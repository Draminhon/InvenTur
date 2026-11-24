/// Texto dos Termos de Uso e da Política de Privacidade do SisTur.
///
/// IMPORTANTE:
/// - Trechos marcados com [PREENCHER: ...] dependem de informações do controlador (instituição responsável)
///   e precisam ser completados — e o texto todo revisado pelo jurídico — antes da publicação.
/// - Ao alterar o conteúdo, aumente [termosVersao] aqui E `TERMOS_VERSAO` em apidjango/termos.py:
///   todos os usuários precisarão aceitar a nova versão no próximo login.
library;

const String termosVersao = '1.1';
const String termosVigencia = '17/11/2026';

/// Seção de um documento legal (título + parágrafos).
class SecaoLegal {
  final String titulo;
  final List<String> paragrafos;

  const SecaoLegal(this.titulo, this.paragrafos);
}

// Controlador: o SisTur é um projeto do IFCE — Campus Tianguá (autarquia federal; LGPD, arts. 23 a 32).
const _instituicao = 'Instituto Federal de Educação, Ciência e Tecnologia do Ceará (IFCE) — Campus Tianguá';
const _controlador = '$_instituicao, autarquia federal vinculada ao Ministério da Educação, inscrita no CNPJ '
    'sob o nº 10.744.098/0019-74, com endereço na Rodovia CE-187, Tianguá/CE, CEP 62320-000';
const _emailDados = 'sisturcontato@gmail.com';
const _encarregado = 'o canal de atendimento sobre tratamento de dados pessoais do SisTur, pelo e-mail $_emailDados';

const List<SecaoLegal> termosDeUso = [
  SecaoLegal('1. Aceitação', [
    'Estes Termos de Uso regulam o uso do aplicativo SisTur, disponibilizado por $_controlador '
        '("nós"). Ao criar uma conta ou utilizar o aplicativo, você declara que leu, compreendeu e concorda com '
        'estes Termos e com a Política de Privacidade. Se não concordar, não utilize o aplicativo.',
  ]),
  SecaoLegal('2. O que é o SisTur', [
    'O SisTur é um projeto de pesquisa e extensão do $_instituicao para a realização do inventário da '
        'oferta turística de municípios: administradores criam pesquisas e formam equipes, e pesquisadores '
        'registram em campo informações sobre equipamentos, serviços e atrativos turísticos, inclusive sem '
        'conexão com a internet, sincronizando os dados quando a conexão estiver disponível.',
    'O uso do aplicativo é gratuito.',
  ]),
  SecaoLegal('3. Cadastro e conta', [
    'O uso do aplicativo é destinado a pessoas maiores de 18 anos.',
    'Você se compromete a informar dados verdadeiros e atualizados no cadastro. O e-mail informado é o seu '
        'identificador de acesso.',
    'A conta é pessoal e intransferível. Você é responsável por manter sua senha em sigilo e por todas as '
        'atividades realizadas com a sua conta. Se suspeitar de uso indevido, altere sua senha e nos avise '
        'imediatamente pelos canais indicados ao final.',
    'O acesso às pesquisas pode depender de aprovação por um administrador e do vínculo à equipe da pesquisa.',
  ]),
  SecaoLegal('4. Perfis de acesso', [
    'Administrador: cria e gerencia pesquisas, define equipes, acompanha os dados inventariados e pode '
        'exportá-los. Cada administrador tem acesso apenas às pesquisas que criou.',
    'Pesquisador: registra e edita os formulários das pesquisas das quais faz parte. O código de vínculo de '
        'uma pesquisa deve ser compartilhado apenas com os membros da equipe e não pode ser divulgado publicamente.',
  ]),
  SecaoLegal('5. Coleta de informações em campo', [
    'Ao registrar formulários, você poderá coletar informações sobre estabelecimentos e sobre pessoas '
        '(por exemplo: responsáveis, contatos e guias de turismo). Nesses casos, você deve:',
    '• coletar somente as informações necessárias ao inventário, solicitadas nos formulários;',
    '• informar ao entrevistado quem realiza a pesquisa, a sua finalidade e que os dados serão registrados '
        'no SisTur, respeitando a recusa em fornecer informações;',
    '• dar preferência a dados institucionais e comerciais (de empresas e órgãos) em vez de dados pessoais;',
    '• nunca registrar dados pessoais sensíveis (como origem racial ou étnica, convicção religiosa, opinião '
        'política, filiação sindical, dados de saúde, vida sexual, dados genéticos ou biométricos);',
    '• não utilizar as informações coletadas para nenhuma outra finalidade (como venda, marketing ou uso pessoal).',
  ]),
  SecaoLegal('6. Condutas proibidas', [
    'É proibido: inserir informações falsas; acessar ou tentar acessar dados de pesquisas das quais você não '
        'faz parte; compartilhar sua conta; tentar burlar mecanismos de segurança, sobrecarregar ou interferir '
        'no funcionamento do sistema; copiar, divulgar ou comercializar dados obtidos por meio do aplicativo.',
    'O descumprimento destes Termos pode levar à suspensão ou exclusão da conta, sem prejuízo das '
        'responsabilidades civis, administrativas e criminais cabíveis.',
  ]),
  SecaoLegal('7. Dados do inventário', [
    'As informações registradas nas pesquisas destinam-se à finalidade do inventário turístico e são tratadas '
        'pelo IFCE — Campus Tianguá para fins de pesquisa, ensino e extensão, podendo ser utilizadas em estudos, '
        'no planejamento turístico e na divulgação de informações turísticas, observada a Política de Privacidade. '
        'Sempre que possível, os resultados serão divulgados de forma agregada ou anonimizada.',
  ]),
  SecaoLegal('8. Uso offline e sincronização', [
    'Formulários preenchidos sem conexão ficam armazenados no seu aparelho até serem enviados. Cabe a você '
        'sincronizá-los assim que possível. Em caso de perda, furto ou troca do aparelho, comunique um '
        'administrador e altere sua senha.',
  ]),
  SecaoLegal('9. Disponibilidade e responsabilidade', [
    'Empregamos esforços para manter o aplicativo disponível e seguro, mas ele pode passar por '
        'interrupções, manutenções ou falhas. Não nos responsabilizamos por danos decorrentes do uso indevido '
        'do aplicativo pelo usuário, de informações inseridas por terceiros ou de falhas de conexão e '
        'equipamentos fora do nosso controle, ressalvados os direitos garantidos por lei.',
  ]),
  SecaoLegal('10. Encerramento da conta', [
    'Você pode solicitar a exclusão da sua conta a qualquer momento pelos canais indicados ao final. '
        'Os dados serão tratados conforme os prazos de retenção da Política de Privacidade.',
  ]),
  SecaoLegal('11. Alterações destes Termos', [
    'Estes Termos podem ser atualizados. Quando isso ocorrer, a nova versão será apresentada no aplicativo '
        'e será necessário aceitá-la para continuar utilizando-o.',
  ]),
  SecaoLegal('12. Lei aplicável e foro', [
    'Estes Termos são regidos pelas leis da República Federativa do Brasil. Por se tratar de autarquia federal, '
        'eventuais controvérsias serão processadas pela Justiça Federal — Seção Judiciária do Ceará, nos termos '
        'do art. 109, I, da Constituição Federal, ressalvadas as hipóteses de competência legal diversa.',
  ]),
  SecaoLegal('13. Contato', [
    'Dúvidas sobre estes Termos: equipe do projeto SisTur no IFCE — Campus Tianguá, pelo e-mail '
        '$_emailDados. Questões sobre dados pessoais: $_encarregado. '
        'Também é possível usar os canais oficiais do IFCE, como a Ouvidoria e a plataforma Fala.BR.',
  ]),
];

const List<SecaoLegal> politicaDePrivacidade = [
  SecaoLegal('1. Quem é o controlador', [
    'O controlador dos dados pessoais tratados no SisTur é $_controlador. '
        'Dúvidas, solicitações e reclamações sobre o tratamento de dados pessoais devem ser enviadas para '
        '$_encarregado.',
    'Esta Política explica, conforme a Lei Geral de Proteção de Dados Pessoais (Lei nº 13.709/2018 — LGPD), '
        'quais dados tratamos, para quê, com quem compartilhamos e como você pode exercer seus direitos. '
        'Como instituição pública, o IFCE observa também as regras de tratamento de dados pelo Poder Público '
        '(arts. 23 a 32 da LGPD) e a Lei de Acesso à Informação (Lei nº 12.527/2011).',
  ]),
  SecaoLegal('2. Dados dos usuários do aplicativo', [
    '• Cadastro: nome, e-mail, telefone e senha (armazenada apenas de forma cifrada e irreversível, '
        'sem que ninguém tenha acesso a ela);',
    '• Foto de perfil, apenas se você optar por enviá-la;',
    '• Informações da conta: nível de acesso (administrador ou pesquisador), situação do cadastro e pesquisas '
        'às quais você está vinculado;',
    '• Registro de atividade: autoria e data/hora dos formulários que você cria ou edita;',
    '• Registro do aceite destes documentos (versão aceita e data/hora);',
    '• Dados técnicos de acesso, como endereço IP e data/hora das requisições aos servidores.',
  ]),
  SecaoLegal('3. Localização', [
    'Com a sua permissão (concedida nas configurações do aparelho), o aplicativo utiliza a localização do '
        'aparelho para registrar as coordenadas dos equipamentos inventariados e exibir mapas. '
        'Não realizamos rastreamento contínuo da sua localização. Você pode revogar a permissão a qualquer '
        'momento nas configurações do aparelho; algumas funções de mapa podem deixar de funcionar.',
  ]),
  SecaoLegal('4. Dados de terceiros coletados no inventário', [
    'Os formulários do inventário registram informações sobre estabelecimentos, serviços e atrativos '
        'turísticos, que podem incluir dados pessoais de terceiros, como nome, e-mail, telefone/WhatsApp e '
        'endereço de responsáveis e contatos; nome, CPF, contato e registro no Cadastur de guias de turismo; '
        'e nomes de dirigentes e gestores públicos.',
    'Esses dados são coletados exclusivamente para a finalidade do inventário turístico e tratados com as '
        'mesmas medidas de segurança desta Política. Os titulares podem exercer seus direitos pelos canais '
        'indicados nesta Política.',
  ]),
  SecaoLegal('5. Para que usamos os dados', [
    '• Criar e manter sua conta, autenticar seu acesso e recuperar sua senha;',
    '• Organizar as pesquisas, as equipes e o controle de acesso aos dados;',
    '• Realizar o inventário da oferta turística e gerar relatórios, painéis e exportações para os '
        'administradores das pesquisas;',
    '• Garantir a segurança do sistema, prevenir fraudes e acessos indevidos;',
    '• Cumprir obrigações legais e regulatórias.',
  ]),
  SecaoLegal('6. Bases legais', [
    'O IFCE trata dados pessoais no exercício de suas competências legais de ensino, pesquisa e extensão '
        '(art. 23 da LGPD e Lei nº 11.892/2008), com fundamento no art. 7º da LGPD:',
    '• realização de estudos por órgão de pesquisa (inciso IV), para o inventário turístico — garantida, '
        'sempre que possível, a anonimização dos dados pessoais;',
    '• execução de políticas públicas (inciso III), quando o inventário apoiar ações públicas de turismo;',
    '• execução de contrato ou de procedimentos preliminares relacionados a ele (inciso V), para a sua conta;',
    '• cumprimento de obrigação legal ou regulatória (inciso II);',
    '• consentimento (inciso I), para a foto de perfil e a localização do aparelho.',
  ]),
  SecaoLegal('7. Compartilhamento', [
    'Não vendemos dados pessoais. Os dados podem ser compartilhados com:',
    '• Administradores da pesquisa: os dados dos formulários e a identificação do pesquisador que os registrou;',
    '• Prestadores de serviço e infraestrutura: os servidores do SisTur são hospedados na infraestrutura do '
        'IFCE (nupreds.ifce.edu.br); Google, para o envio de e-mails de recuperação de senha; Mapbox e OpenStreetMap, para a '
        'exibição de mapas (recebem o endereço IP e a região do mapa visualizada); IBGE, para a consulta da '
        'lista de estados e municípios (não recebe dados de cadastro);',
    '• Ferramentas de análise utilizadas pelos administradores (como planilhas e Microsoft Power BI), '
        'quando os dados de uma pesquisa são exportados;',
    '• Autoridades públicas, quando exigido por lei ou ordem judicial.',
  ]),
  SecaoLegal('8. Transferência internacional', [
    'Alguns prestadores de serviço (como Mapbox e Google) podem tratar dados fora do Brasil. Nesses casos, a '
        'transferência observa as hipóteses do art. 33 da LGPD, com a adoção de garantias adequadas de proteção.',
  ]),
  SecaoLegal('9. Segurança', [
    'Adotamos medidas técnicas e administrativas para proteger os dados, entre elas: criptografia de dados '
        'pessoais armazenados no banco de dados; senhas cifradas de forma irreversível; comunicação criptografada '
        '(HTTPS); credenciais de acesso com validade limitada; e controle de acesso por perfil e por pesquisa, '
        'de modo que cada administrador acesse apenas as pesquisas que criou e cada pesquisador apenas as da '
        'sua equipe. No aparelho, as credenciais ficam em armazenamento seguro e os formulários pendentes de '
        'envio ficam salvos localmente até a sincronização.',
    'Em caso de incidente de segurança que possa acarretar risco ou dano relevante, comunicaremos a Autoridade '
        'Nacional de Proteção de Dados (ANPD) e os titulares afetados, conforme o art. 48 da LGPD.',
  ]),
  SecaoLegal('10. Por quanto tempo guardamos', [
    '• Dados da conta (nome, e-mail, telefone e foto): enquanto a conta estiver ativa. Após a exclusão da '
        'conta, são eliminados em até 30 dias, exceto o mínimo necessário para comprovar a autoria dos '
        'formulários registrados e o aceite destes documentos, mantido por até 5 anos para o exercício regular '
        'de direitos (prazo prescricional das ações contra a Administração Pública, Decreto nº 20.910/1932);',
    '• Contas inativas: contas sem acesso por mais de 2 anos e sem vínculo com pesquisas em andamento poderão '
        'ser desativadas e ter seus dados eliminados, com aviso prévio ao e-mail cadastrado;',
    '• Dados do inventário: enquanto a pesquisa estiver em andamento e por até 5 anos após a sua conclusão, '
        'para fins de pesquisa, prestação de contas e verificação dos resultados. Após esse prazo, os dados '
        'pessoais de terceiros (como nomes, contatos e CPF de responsáveis e guias) são eliminados ou '
        'anonimizados; as informações sobre os estabelecimentos e os resultados agregados podem ser mantidos '
        'para fins estatísticos e históricos;',
    '• Códigos de recuperação de senha: até 10 minutos, ou até o uso;',
    '• Registros de acesso aos servidores: 6 meses.',
    'Ao final dos prazos, os dados são eliminados ou anonimizados, observadas as normas de gestão documental '
        'aplicáveis às instituições federais de ensino. Você pode pedir a exclusão antecipada dos seus dados '
        'pelo e-mail $_emailDados, ressalvadas as hipóteses de guarda previstas em lei.',
  ]),
  SecaoLegal('11. Seus direitos', [
    'Nos termos do art. 18 da LGPD, você pode solicitar: confirmação da existência de tratamento; acesso aos '
        'dados; correção de dados incompletos, inexatos ou desatualizados; anonimização, bloqueio ou eliminação '
        'de dados desnecessários, excessivos ou tratados em desconformidade com a lei; portabilidade; '
        'eliminação dos dados tratados com base no consentimento; informação sobre com quem os dados foram '
        'compartilhados; informação sobre a possibilidade de não fornecer consentimento e suas consequências; '
        'e revogação do consentimento.',
    'Nome, e-mail e telefone podem ser corrigidos diretamente no aplicativo, na tela de perfil. Para as '
        'demais solicitações, escreva para $_emailDados. Responderemos nos prazos '
        'previstos na LGPD.',
    'Você também pode apresentar reclamação à Autoridade Nacional de Proteção de Dados (ANPD).',
  ]),
  SecaoLegal('12. Crianças e adolescentes', [
    'O SisTur não é destinado a menores de 18 anos, e não coletamos intencionalmente dados de crianças '
        'e adolescentes.',
  ]),
  SecaoLegal('13. Alterações desta Política', [
    'Esta Política pode ser atualizada. A versão vigente estará sempre disponível no aplicativo e, em caso '
        'de alterações relevantes, será solicitado um novo aceite.',
  ]),
];
