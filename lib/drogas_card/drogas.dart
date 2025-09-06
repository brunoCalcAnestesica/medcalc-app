import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared_data.dart';
import '../bulario_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'diureticos/manitol.dart' show MedicamentoManitol;
import 'diureticos/furosemida.dart' show MedicamentoFurosemida;
import 'diureticos/bumetadina.dart' show MedicamentoBumetanida;
import 'diureticos/torasemida.dart' show MedicamentoTorasemida;
import 'bloquadores_neuromusculares/succinilcolina.dart' show MedicamentoSuccinilcolina;
import 'bloquadores_neuromusculares/rocuronio.dart' show MedicamentoRocuronio;
import 'bloquadores_neuromusculares/vecuronio.dart' show MedicamentoVecuronio;
import 'bloquadores_neuromusculares/atracurio.dart' show MedicamentoAtracurio;
import 'bloquadores_neuromusculares/cisatracurio.dart' show MedicamentoCisatracurio;
import 'bloquadores_neuromusculares/mivacurio.dart' show MedicamentoMivacurio;
import 'bloquadores_neuromusculares/pancuronio.dart' show MedicamentoPancuronio;
import 'benzodiazepinicos/midazolam.dart' show MedicamentoMidazolam;
import 'benzodiazepinicos/diazepam.dart' show MedicamentoDiazepam;
import 'benzodiazepinicos/lorazepam.dart' show MedicamentoLorazepam;
import 'benzodiazepinicos/flumazenil.dart' show MedicamentoFlumazenil;
import 'benzodiazepinicos/remimazolam.dart' show MedicamentoRemimazolam;
import 'reversores_antidotos/naloxona.dart';
import 'reversores_antidotos/sugamadex.dart' show MedicamentoSugamadex;
import 'reversores_antidotos/protamina.dart';
import 'reversores_antidotos/dantroleno.dart';
import 'reversores_antidotos/tiossulfato_sodio.dart' show MedicamentoTiossulfatoSodio;
import 'reversores_antidotos/hidroxicobalamina.dart';
import 'reversores_antidotos/neostigmina.dart';
import 'reversores_antidotos/timoglobulina.dart';
import 'anticoagulantes_antifibrinoliticos/heparina_sodica.dart' show MedicamentoHeparinaSodica;
import 'anticoagulantes_antifibrinoliticos/enoxaparina.dart' show MedicamentoEnoxaparina;
import 'anticoagulantes_antifibrinoliticos/alteplase.dart' show MedicamentoAlteplase;
import 'anticoagulantes_antifibrinoliticos/acido_aminocaproico.dart' show MedicamentoAcidoAminocaproico;
import 'anticoagulantes_antifibrinoliticos/acido_tranexamico.dart' show MedicamentoAcidoTranexamico;
import 'anticolinergicos_broncodilatadores/atropina.dart' show MedicamentoAtropina;
import 'anticolinergicos_broncodilatadores/terbutalina.dart' show MedicamentoTerbutalina;
import 'anticolinergicos_broncodilatadores/ipatropio.dart' show MedicamentoIpatropio;
import 'anticolinergicos_broncodilatadores/fenoterol.dart' show MedicamentoFenoterol;
import 'anticolinergicos_broncodilatadores/salbutamol.dart' show MedicamentoSalbutamol;
import 'vasopressores_hipotensores/adrenalina.dart' show MedicamentoAdrenalina;
import 'vasopressores_hipotensores/noradrenalina.dart' show MedicamentoNoradrenalina;
import 'vasopressores_hipotensores/dopamina.dart' show MedicamentoDopamina;
import 'vasopressores_hipotensores/vasopressina.dart' show MedicamentoVasopressina;
import 'vasopressores_hipotensores/dobutamina.dart' show MedicamentoDobutamina;
import 'vasopressores_hipotensores/fenilefrina.dart' show MedicamentoFenilefrina;
import 'vasopressores_hipotensores/nitroglicerina.dart' show MedicamentoNitroglicerina;
import 'vasopressores_hipotensores/nitroprussiato.dart' show MedicamentoNitroprussiato;
import 'vasopressores_hipotensores/efedrina.dart' show MedicamentoEfedrina;
import 'vasopressores_hipotensores/metaraminol.dart' show MedicamentoMetaraminol;
import 'vasopressores_hipotensores/milrinona.dart' show MedicamentoMilrinona;
import 'antibioticos/ceftriaxona.dart';
import 'antibioticos/cefuroxima.dart';
import 'antibioticos/cefazolina.dart';
import 'antibioticos/metronidazol.dart';
import 'antibioticos/vancomicina.dart';
import 'antibioticos/clindamicina.dart';
import 'analgesicos_antipireticos/paracetamol.dart';
import 'analgesicos_antipireticos/dipirona.dart';
import 'anestesicos_inalatorios/isoflurano.dart';
import 'anestesicos_inalatorios/desflurano.dart';
import 'anestesicos_inalatorios/sevoflurano.dart';
import 'anestesicos_inalatorios/oxido_nitroso.dart';
import 'anestesicos_inalatorios/enflurano.dart';
import 'anestesicos_inalatorios/halotano.dart';
import 'anestesicos_inalatorios/oxido_nitrico.dart';
import 'anestesicos_locais/lidocaina.dart' show MedicamentoLidocaina;
import 'anestesicos_locais/bupivacaina.dart' show MedicamentoBupivacaina;
import 'anestesicos_locais/ropivacaina.dart' show MedicamentoRopivacaina;
import 'anestesicos_locais/lidocaina_antiarritmica.dart' show MedicamentoLidocainaAntiarritmica;
import 'solucoes_expansao/emulsao_lipidica.dart' show MedicamentoEmulsaoLipidica;
import 'solucoes_expansao/agua_destilada.dart' show MedicamentoAguaDestilada;
import 'solucoes_expansao/soro_fisiologico.dart';
import 'solucoes_expansao/plasma_lyte.dart' show MedicamentoPlasmaLyte;
import 'solucoes_expansao/coloides.dart' show MedicamentoColoides;
import 'solucoes_expansao/solucao_salina_hipertonica.dart' show MedicamentoSolucaoSalinaHipertonica;
import 'solucoes_expansao/solucao_salina_20.dart' show MedicamentoSolucaoSalina20;
import 'uterotonicos/ergometrina.dart' show MedicamentoErgometrina;
import 'uterotonicos/ocitocina.dart' show MedicamentoOcitocina;
import 'corticosteroides/hidrocortisona.dart' show MedicamentoHidrocortisona;
import 'corticosteroides/dexametasona.dart' show MedicamentoDexametasona;
import 'corticosteroides/metilprednisolona.dart' show MedicamentoMetilprednisolona;
import 'corticosteroides/betametasona.dart' show MedicamentoBetametasona;
import 'eletroliticos_criticos/sulfato_magnesio.dart' show MedicamentoSulfatoMagnesio;
import 'eletroliticos_criticos/gluconato_calcio.dart' show MedicamentoGluconatoCalcio;
import 'eletroliticos_criticos/cloreto_calcio.dart' show MedicamentoCloretoCalcio;
import 'eletroliticos_criticos/cloreto_potassio.dart' show MedicamentoCloretoPotassio;
import 'eletroliticos_criticos/bicarbonato_sodio.dart' show MedicamentoBicarbonatoSodio;
import 'antiarritmicos/metoprolol.dart' show MedicamentoMetoprolol;
import 'antiarritmicos/amiodarona.dart' show MedicamentoAmiodarona;
import 'antiarritmicos/esmolol.dart' show MedicamentoEsmolol;
import 'antiarritmicos/adenosina.dart' show MedicamentoAdenosina;
import 'antiemeticos/droperidol.dart' show MedicamentoDroperidol;
import 'antiemeticos/metoclopramida.dart' show MedicamentoMetoclopramida;
import 'antiemeticos/bromoprida.dart' show MedicamentoBromoprida;
import 'antiemeticos/hioscina.dart' show MedicamentoHioscina;
import 'antiemeticos/dimenidrinato.dart' show MedicamentoDimenidrinato;
import 'indutores_anestesicos/cetamina.dart' show MedicamentoCetamina;
import 'indutores_anestesicos/tiopental.dart' show MedicamentoTiopental;
import 'indutores_anestesicos/etomidato.dart' show MedicamentoEtomidato;
import 'indutores_anestesicos/dextrocetamina.dart';
import 'indutores_anestesicos/propofol.dart' show MedicamentoPropofol;
import 'anticonvulsivantes_emergencia/fenitoina.dart' show MedicamentoFenitoina;
import 'anticonvulsivantes_emergencia/fenobarbital.dart' show MedicamentoFenobarbital;
import 'controle_glicemia/insulina_regular.dart' show MedicamentoInsulinaRegular;
import 'controle_glicemia/glicose_50.dart' show MedicamentoGlicose50;
import 'outros/picada_cobra.dart';
import 'outros/azul_metileno.dart' show MedicamentoAzulMetileno;
import 'opioides_analgesicos/tramadol.dart' show MedicamentoTramadol;
import 'opioides_analgesicos/fentanil.dart' show MedicamentoFentanil;
import 'opioides_analgesicos/buprenorfina.dart' show MedicamentoBuprenorfina;
import 'opioides_analgesicos/alfentanil.dart' show MedicamentoAlfentanil;
import 'opioides_analgesicos/sufentanil.dart' show MedicamentoSufentanil;
import 'opioides_analgesicos/remifentanil.dart' show MedicamentoRemifentanil;
import 'opioides_analgesicos/petidina.dart' show MedicamentoPetidina;
import 'opioides_analgesicos/pentazocina.dart' show MedicamentoPentazocina;
import 'opioides_analgesicos/nalbuphina.dart' show MedicamentoNalbuphina;
import 'opioides_analgesicos/morfina.dart' show MedicamentoMorfina;
import 'opioides_analgesicos/metadona.dart' show MedicamentoMetadona;
import 'alfa2_agonistas/clonidina.dart' show MedicamentoClonidina;
import 'alfa2_agonistas/dexmedetomidina.dart' show MedicamentoDexmedetomidina;
import 'anti_inflamatorios/diclofenaco.dart' show Diclofenaco;
import 'anti_inflamatorios/cetorolaco.dart' show Cetorolaco;
import 'anti_inflamatorios/tenoxicam.dart' show Tenoxicam;
import 'anti_inflamatorios/dexketoprofeno.dart' show Dexketoprofeno;
import 'anti_inflamatorios/ibuprofeno.dart' show Ibuprofeno;


//CONFIGURAÇÕES//
/**/Widget buildMedicamentoExpansivel({
  required BuildContext context,
  required String nome,
  required String idBulario,
  required bool isFavorito,
  required VoidCallback onToggleFavorito,
  required Widget conteudo,
}) {
  return _MedicamentoCardWrapper(
    nome: nome,
    idBulario: idBulario,
    isFavorito: isFavorito,
    onToggleFavorito: onToggleFavorito,
    conteudo: conteudo,
  );
}

class _MedicamentoCardWrapper extends StatefulWidget {
  final String nome;
  final String idBulario;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;
  final Widget conteudo;

  const _MedicamentoCardWrapper({
    required this.nome,
    required this.idBulario,
    required this.isFavorito,
    required this.onToggleFavorito,
    required this.conteudo,
  });

  @override
  State<_MedicamentoCardWrapper> createState() => _MedicamentoCardWrapperState();
}

class _MedicamentoCardWrapperState extends State<_MedicamentoCardWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Sempre manter vivo

  @override
  Widget build(BuildContext context) {
    super.build(context); // Necessário para AutomaticKeepAliveClientMixin
    return _CustomExpansionCard(
      nome: widget.nome,
      isFavorito: widget.isFavorito,
      onToggleFavorito: widget.onToggleFavorito,
      onBularioPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BularioPage(principioAtivo: widget.idBulario),
          ),
        );
      },
      conteudo: widget.conteudo,
    );
  }
}

class _CustomExpansionCard extends StatefulWidget {
  final String nome;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;
  final VoidCallback onBularioPressed;
  final Widget conteudo;

  const _CustomExpansionCard({
    required this.nome,
    required this.isFavorito,
    required this.onToggleFavorito,
    required this.onBularioPressed,
    required this.conteudo,
  });

  @override
  State<_CustomExpansionCard> createState() => _CustomExpansionCardState();
}

class _CustomExpansionCardState extends State<_CustomExpansionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;
  static final Map<String, bool> _expansionStates = {};
  
  // Getter para acessar os estados de expansão (para debug)
  static Map<String, bool> get expansionStates => Map.unmodifiable(_expansionStates);
  static const String _expansionKey = 'medicamentosExpansionStates';
  
  // Método estático para limpar todos os estados de expansão
  static void clearExpansionStates() {
    _expansionStates.clear();
    _saveExpansionStates();
  }
  
  // Salvar estados de expansão no SharedPreferences
  static Future<void> _saveExpansionStates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expansionList = _expansionStates.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
      await prefs.setStringList(_expansionKey, expansionList);
      // Debug: print para verificar se está salvando
      print('Estados de expansão salvos: $expansionList');
    } catch (e) {
      print('Erro ao salvar estados de expansão: $e');
    }
  }
  
  // Carregar estados de expansão do SharedPreferences
  static Future<void> _loadExpansionStates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expansionList = prefs.getStringList(_expansionKey) ?? [];
      for (final nome in expansionList) {
        _expansionStates[nome] = true;
      }
      // Debug: print para verificar se está carregando
      print('Estados de expansão carregados: $expansionList');
    } catch (e) {
      print('Erro ao carregar estados de expansão: $e');
    }
  }
  
  // Inicializar estados de expansão (chamar uma vez no início do app)
  static Future<void> initializeExpansionStates() async {
    print('Carregando estados de expansão do SharedPreferences...');
    await _loadExpansionStates();
    print('Estados de expansão carregados. Total de cards expandidos: ${_expansionStates.length}');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
    
    // Restaurar estado de expansão
    _isExpanded = _expansionStates[widget.nome] ?? false;
    print('Card ${widget.nome} - Estado inicial: $_isExpanded (Total de estados: ${_expansionStates.length})');
    
    if (_isExpanded) {
      _controller.value = 1.0;
      print('Card ${widget.nome} - Animação configurada para expandido');
    }
    
    // Garantir que o estado seja salvo se já estiver expandido
    if (_isExpanded && !_expansionStates.containsKey(widget.nome)) {
      _expansionStates[widget.nome] = true;
      _saveExpansionStates();
      print('Card ${widget.nome} - Estado salvo como expandido');
    }
  }



  @override
  void dispose() {
    _controller.dispose();
    // Não remover o estado de expansão aqui para manter a persistência
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      _expansionStates[widget.nome] = _isExpanded;
      print('Card ${widget.nome} - Toggle para: $_isExpanded');
      
      if (_isExpanded) {
        _controller.forward();
        print('Card ${widget.nome} - Animação expandindo');
      } else {
        _controller.reverse();
        print('Card ${widget.nome} - Animação contraindo');
      }
    });
    // Salvar estado de expansão imediatamente
    _saveExpansionStates();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: PageStorageKey<String>('expansion_${widget.nome}'),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: _toggleExpansion,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          widget.isFavorito ? Icons.star_rounded : Icons.star_border_rounded,
                          color: widget.isFavorito ? Colors.amber[700] : Colors.grey[400],
                          size: 24,
                        ),
                        tooltip: widget.isFavorito ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
                        onPressed: widget.onToggleFavorito,
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        icon: const Icon(Icons.medical_information_rounded, size: 24, color: Colors.blueGrey),
                        tooltip: 'Abrir bulário',
                        onPressed: widget.onBularioPressed,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Content
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: _isExpanded
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: widget.conteudo,
                        )
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
/**/ class FavoritosManager {
  static const _key = 'medicamentosFavoritos';

  static Future<Set<String>> obterFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.toSet() ?? {};
  }

  static Future<void> salvarFavorito(
      String nomeMedicamento, bool favorito) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritos = prefs.getStringList(_key)?.toSet() ?? {};

    if (favorito) {
      favoritos.add(nomeMedicamento);
    } else {
      favoritos.remove(nomeMedicamento);
    }

    await prefs.setStringList(_key, favoritos.toList());
  }
}
/**/ class DrogasPage extends StatefulWidget {
  const DrogasPage({super.key});

  @override
  State<DrogasPage> createState() => _DrogasPageState();
}
/**/ class ConversaoInfusaoSlider extends StatefulWidget {
  final double peso;
  final Map<String, double> opcoesConcentracoes;
  final double doseMin;
  final double doseMax;
  final String unidade;

  const ConversaoInfusaoSlider({
    Key? key,
    required this.peso,
    required this.opcoesConcentracoes,
    required this.doseMin,
    required this.doseMax,
    required this.unidade,
  }) : super(key: key ?? const ValueKey('ConversaoInfusaoSlider'));

  @override
  State<ConversaoInfusaoSlider> createState() => _ConversaoInfusaoSliderState();
}
/**/ class _ConversaoInfusaoSliderState extends State<ConversaoInfusaoSlider> {
  late String concentracaoSelecionada;
  late double dose;
  late double mlHora;
  bool _isDropdownOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    // Garantir que sempre há uma concentração válida selecionada
    if (widget.opcoesConcentracoes.isNotEmpty) {
      concentracaoSelecionada = widget.opcoesConcentracoes.keys.first;
    } else {
      concentracaoSelecionada = '';
    }
    dose = widget.doseMin.clamp(widget.doseMin, widget.doseMax);
    mlHora = _calcularMlHora();
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 280,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 50),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 200),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: Opacity(
                  opacity: value,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(8),
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: widget.opcoesConcentracoes.length,
                          itemBuilder: (context, index) {
                            final opcao = widget.opcoesConcentracoes.keys.elementAt(index);
                            final isSelected = opcao == concentracaoSelecionada;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? Colors.indigo.withOpacity(0.1) 
                                    : Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                title: Text(
                                  opcao,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    color: isSelected ? Colors.indigo : Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: isSelected 
                                    ? Icon(
                                        Icons.check,
                                        size: 18,
                                        color: Colors.indigo,
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    concentracaoSelecionada = opcao;
                                    mlHora = _calcularMlHora();
                                  });
                                  _removeOverlay();
                                },
                                tileColor: Colors.transparent,
                                hoverColor: Colors.indigo.withOpacity(0.05),
                                splashColor: Colors.indigo.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
  }

  double _calcularMlHora() {
    if (concentracaoSelecionada.isEmpty || !widget.opcoesConcentracoes.containsKey(concentracaoSelecionada)) {
      return 0;
    }
    
    final conc = widget.opcoesConcentracoes[concentracaoSelecionada];
    if (conc == null || conc == 0) return 0;
    final unidade = widget.unidade.toLowerCase();

    final isMg = unidade.contains('mg');
    final isPerMin = unidade.contains('/min');

    final fatorPeso = widget.peso;
    final fatorTempo = isPerMin ? 60 : 1;
    final fatorUnidade = isMg ? 1000 : 1; // se for mg, converte para mcg

    final doseConvertida = dose * fatorUnidade;

    return (doseConvertida * fatorPeso * fatorTempo) / conc;
  }

  @override
  Widget build(BuildContext context) {
    // Garantir que sempre há uma concentração válida
    if (concentracaoSelecionada.isEmpty && widget.opcoesConcentracoes.isNotEmpty) {
      concentracaoSelecionada = widget.opcoesConcentracoes.keys.first;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: _isDropdownOpen ? Colors.indigo.withOpacity(0.05) : Colors.white,
                border: Border.all(
                  color: _isDropdownOpen ? Colors.indigo : Colors.grey.shade400,
                  width: _isDropdownOpen ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: _isDropdownOpen ? [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      concentracaoSelecionada.isNotEmpty 
                          ? concentracaoSelecionada 
                          : 'Selecionar Solução',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: _isDropdownOpen ? FontWeight.w600 : FontWeight.normal,
                        color: concentracaoSelecionada.isNotEmpty 
                            ? (_isDropdownOpen ? Colors.indigo : Colors.black87)
                            : Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _isDropdownOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: _isDropdownOpen ? Colors.indigo : Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('${dose.toStringAsFixed(1)} ${widget.unidade}',
                style: const TextStyle(fontSize: 14)),
            const Spacer(),
            Text(
              '${mlHora.toStringAsFixed(1)} mL/h',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
          ],
        ),
        Slider(
          value: dose.clamp(widget.doseMin, widget.doseMax),
          min: widget.doseMin,
          max: widget.doseMax,
          divisions: ((widget.doseMax - widget.doseMin) * 100).round(),
          label: '${dose.toStringAsFixed(1)}',
          onChanged: (valor) {
            setState(() {
              dose = valor;
              mlHora = _calcularMlHora();
            });
          },
        ),
      ],
    );
  }
}
/**/ Widget buildEstrelaFavorito({
  required bool isFavorito,
  required VoidCallback onToggle,
}) {return IconButton(icon: Icon(
    isFavorito ? Icons.star_rounded : Icons.star_border_rounded,
    color: isFavorito ? Colors.amber[700] : Colors.grey[400],
    size: 26,
  ), tooltip: isFavorito ? 'Remover dos favoritos' : 'Adicionar aos favoritos', onPressed: onToggle, padding: const EdgeInsets.all(0), visualDensity: VisualDensity.compact, constraints: const BoxConstraints(),);}
/**/ Widget _linhaIndicacaoDoseFixa({required String titulo, required String descricaoDose, required String unidade, required double valorMinimo, required double valorMaximo,}) {return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 4),
        Text(descricaoDose, textAlign: TextAlign.justify),
        const SizedBox(height: 4),
        Text(
          'Dose: ${valorMinimo.toStringAsFixed(1)} – ${valorMaximo.toStringAsFixed(1)} $unidade',
          style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
        ),
        const Divider(),
      ],
    ),
  );}
/**/ Widget _linhaPreparo(String descricao, String concentracao) {final bool temTextoDireito = concentracao.trim().isNotEmpty;return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Expanded(
          flex: temTextoDireito ? 7 : 10,
          child: Text(
            descricao,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        if (temTextoDireito)
          Expanded(
            flex: 3,
            child: Text(
              concentracao,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    ),
  );}
/**/ Widget _textoObs(String texto) {return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(
      texto,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 14),
    ),
  );}
/**/ Widget _linhaIndicacaoDoseCalculada({
  required String titulo,
  required String descricaoDose,
  double? dosePorKg,
  double? dosePorKgMinima,
  double? dosePorKgMaxima,
  double? doseMaxima,
  String? unidade,
  required double peso,}) { String resultadoTexto = '';if (dosePorKg != null) {
    double calculado = dosePorKg * peso;
    if (doseMaxima != null && calculado > doseMaxima) {
      calculado = doseMaxima;
    }
    resultadoTexto = '${calculado.toStringAsFixed(1)}${unidade != null && unidade.isNotEmpty ? ' $unidade' : ''}';
  } else if (dosePorKgMinima != null && dosePorKgMaxima != null) {double min = dosePorKgMinima * peso;double max = dosePorKgMaxima * peso;if (doseMaxima != null) {
      if (min > doseMaxima) min = doseMaxima;
      if (max > doseMaxima) max = doseMaxima;
    }if (min.toStringAsFixed(1) == max.toStringAsFixed(1)) {
      resultadoTexto = '${min.toStringAsFixed(1)}${unidade != null && unidade.isNotEmpty ? ' $unidade' : ''}';
    } else {resultadoTexto = '${min.toStringAsFixed(1)} - ${max.toStringAsFixed(1)}${unidade != null && unidade.isNotEmpty ? ' $unidade' : ''}';}} else if (unidade != null && unidade.isNotEmpty) {
    resultadoTexto = unidade;
  }final bool mostrarDireita = resultadoTexto.isNotEmpty;return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: mostrarDireita ? 7 : 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text('$descricaoDose', textAlign: TextAlign.justify, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        if (mostrarDireita)
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                resultadoTexto,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
      ],
    ),
  );}
//CONFIGURAÇÕES//

/* LISTA DE MEDICAMENTOS */ /**/
class _DrogasPageState extends State<DrogasPage> {
  Set<String> favoritos = {};
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
    _initializeExpansionStates();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.toLowerCase();
      });
    });
  }
  
  Future<void> _initializeExpansionStates() async {
    print('Inicializando estados de expansão...');
    await _CustomExpansionCardState.initializeExpansionStates();
    print('Estados de expansão inicializados com sucesso');
  }
  
  Future<void> _carregarFavoritos() async {
    final favs = await FavoritosManager.obterFavoritos();
    setState(() {
      favoritos = favs;
    });
  }
  
  void _alternarFavorito(String nomeMedicamento) async {
    final novoEstado = !favoritos.contains(nomeMedicamento);
    await FavoritosManager.salvarFavorito(nomeMedicamento, novoEstado);
    if (!mounted) return;
    setState(() {
      if (novoEstado) {
        favoritos.add(nomeMedicamento);
      } else {
        favoritos.remove(nomeMedicamento);
      }
    });
  }

  Future<Widget> _buildMedicationCard(Map<String, dynamic> med) async {
    try {
      final builderResult = med['builder']();
      
      // Se o resultado é um Future<Widget>, aguardar
      if (builderResult is Future<Widget>) {
        return await builderResult;
      } else {
        // Se é um Widget, retornar diretamente
        return builderResult as Widget;
      }
    } catch (e) {
      // Retornar um widget de erro
      return Card(
        child: ListTile(
          leading: const Icon(Icons.error, color: Colors.red),
          title: Text('Erro ao carregar ${med['nome']}'),
          subtitle: Text('$e'),
        ),
      );
    }
  }
  
  // Método para limpar todos os estados de expansão (pode ser chamado de um botão ou menu)
  void _limparEstadosExpansao() {
    print('Limpando todos os estados de expansão...');
    _CustomExpansionCardState.clearExpansionStates();
    setState(() {
      // Força reconstrução da lista
    });
    print('Estados de expansão limpos');
  }
  
  // Método para forçar reconstrução dos cards (pode ser útil para debug)
  void _forcarReconstrucao() {
    print('Forçando reconstrução dos cards...');
    setState(() {
      // Força reconstrução da lista
    });
  }
  
  // Método para verificar estado atual dos cards expandidos
  void _verificarEstados() {
    print('Verificando estados atuais dos cards...');
    final estados = _CustomExpansionCardState.expansionStates;
    print('Total de estados: ${estados.length}');
    estados.forEach((nome, expandido) {
      print('  $nome: $expandido');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double peso = SharedData.peso ?? 70;
    final double? idade = SharedData.idade;
    if (idade == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final bool isAdulto = idade >= 18;
    final List<Map<String, dynamic>> medicamentos = <Map<String, dynamic>>[
      //Adicione os Medicamentos Aqui:
      {
        'nome': MedicamentoAtropina.nome,
        'builder': () => MedicamentoAtropina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Atropina
      {
        'nome': MedicamentoTerbutalina.nome,
        'builder': () => MedicamentoTerbutalina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Terbutalina
      {
        'nome': MedicamentoIpatropio.nome,
        'builder': () => MedicamentoIpatropio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Ipatropio
      {
        'nome': MedicamentoFenoterol.nome,
        'builder': () => MedicamentoFenoterol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Fenoterol
      {
        'nome': MedicamentoSalbutamol.nome,
        'builder': () => MedicamentoSalbutamol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Salbutamol
      {
        'nome': MedicamentoAmiodarona.nome,
        'builder': () => MedicamentoAmiodarona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Amiodarona
      {
        'nome': MedicamentoAdenosina.nome,
        'builder': () => MedicamentoAdenosina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Adenosina
      {
        'nome': MedicamentoAdrenalina.nome,
        'builder': () => MedicamentoAdrenalina.buildCard(
          context,
          favoritos,
          _alternarFavorito
        )
      }, // Adrenalina
      {
        'nome': MedicamentoNoradrenalina.nome,
        'builder': () => MedicamentoNoradrenalina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Noradrenalina
      {
        'nome': MedicamentoVasopressina.nome,
        'builder': () => MedicamentoVasopressina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Vasopressina
      {
        'nome': MedicamentoDobutamina.nome,
        'builder': () => MedicamentoDobutamina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dobutamina
      {
        'nome': MedicamentoDopamina.nome,
        'builder': () => MedicamentoDopamina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dopamina
      {
        'nome': MedicamentoEfedrina.nome,
        'builder': () => MedicamentoEfedrina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Efedrina
      {
        'nome': MedicamentoFenilefrina.nome,
        'builder': () => MedicamentoFenilefrina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Fenilefrina
      {
        'nome': MedicamentoMetaraminol.nome,
        'builder': () => MedicamentoMetaraminol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Metaraminol
      {
        'nome': MedicamentoEsmolol.nome,
        'builder': () => MedicamentoEsmolol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Esmolol
      {
        'nome': MedicamentoMilrinona.nome,
        'builder': () => MedicamentoMilrinona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Milrinona
      {
        'nome': MedicamentoNitroglicerina.nome,
        'builder': () => MedicamentoNitroglicerina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Nitroglicerina
      {
        'nome': MedicamentoNitroprussiato.nome,
        'builder': () => MedicamentoNitroprussiato.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Nitroprussiato
      {
        'nome': MedicamentoSoroFisiologico.nome,
        'builder': () => MedicamentoSoroFisiologico.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Soro Fisiológico
      {
        'nome': MedicamentoSolucaoSalinaHipertonica.nome,
        'builder': () => MedicamentoSolucaoSalinaHipertonica.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Solução Salina Hipertônica 3%
      {
        'nome': MedicamentoSolucaoSalina20.nome,
        'builder': () => MedicamentoSolucaoSalina20.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Solução Salina Hipertônica 20%
      {
        'nome': MedicamentoPlasmaLyte.nome,
        'builder': () => MedicamentoPlasmaLyte.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Plasma-Lyte
      {
        'nome': MedicamentoEmulsaoLipidica.nome,
        'builder': () => MedicamentoEmulsaoLipidica.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Emulsão Lipídica
      {
        'nome': MedicamentoColoides.nome,
        'builder': () => MedicamentoColoides.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Coloides
      {
        'nome': MedicamentoAguaDestilada.nome,
        'builder': () => MedicamentoAguaDestilada.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Água Destilada
      {
        'nome': MedicamentoOcitocina.nome,
        'builder': () => MedicamentoOcitocina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Ocitocina
      {
        'nome': MedicamentoErgometrina.nome,
        'builder': () => MedicamentoErgometrina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Ergometrina
      {
        'nome': MedicamentoTiossulfatoSodio.nome,
        'builder': () => MedicamentoTiossulfatoSodio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Tiossulfato de Sódio
      {
        'nome': MedicamentoSugamadex.nome,
        'builder': () => MedicamentoSugamadex.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Sugamadex
      {
        'nome': MedicamentoProtamina.nome,
        'builder': () => MedicamentoProtamina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Protamina
      {
        'nome': MedicamentoNeostigmina.nome,
        'builder': () => MedicamentoNeostigmina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Neostigmina
      {
        'nome': MedicamentoHidroxicobalamina.nome,
        'builder': () => MedicamentoHidroxicobalamina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Hidroxicobalamina
      {
        'nome': MedicamentoDantroleno.nome,
        'builder': () => MedicamentoDantroleno.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dantroleno
      {
        'nome': MedicamentoTimoglobulina.nome,
        'builder': () => MedicamentoTimoglobulina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Timoglobulina
      {
        'nome': MedicamentoPicadaCobra.nome,
        'builder': () => MedicamentoPicadaCobra.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Picada de Cobra
      {
        'nome': MedicamentoAzulMetileno.nome,
        'builder': () => MedicamentoAzulMetileno.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Azul de Metileno
      {
        'nome': MedicamentoTramadol.nome,
        'builder': () => MedicamentoTramadol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Tramadol
      {
        'nome': MedicamentoSufentanil.nome,
        'builder': () => MedicamentoSufentanil.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Sufentanil
      {
        'nome': MedicamentoRemifentanil.nome,
        'builder': () => MedicamentoRemifentanil.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Remifentanil
      {
        'nome': MedicamentoFentanil.nome,
        'builder': () => MedicamentoFentanil.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Fentanil
      {
        'nome': MedicamentoBuprenorfina.nome,
        'builder': () => MedicamentoBuprenorfina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Buprenorfina
      {
        'nome': MedicamentoAlfentanil.nome,
        'builder': () => MedicamentoAlfentanil.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Alfentanil
      {
        'nome': MedicamentoPetidina.nome,
        'builder': () => MedicamentoPetidina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Petidina
      {
        'nome': MedicamentoPentazocina.nome,
        'builder': () => MedicamentoPentazocina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Pentazocina
      {
        'nome': MedicamentoNalbuphina.nome,
        'builder': () => MedicamentoNalbuphina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Nalbuphina
      {
        'nome': MedicamentoMorfina.nome,
        'builder': () => MedicamentoMorfina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Morfina
      {
        'nome': MedicamentoMetadona.nome,
        'builder': () => MedicamentoMetadona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Metadona
      {
        'nome': MedicamentoTiopental.nome,
        'builder': () => MedicamentoTiopental.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Tiopental
      {
        'nome': MedicamentoPropofol.nome,
        'builder': () => MedicamentoPropofol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Propofol
      {
        'nome': MedicamentoEtomidato.nome,
        'builder': () => MedicamentoEtomidato.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Etomidato
      {
        'nome': MedicamentoCetamina.nome,
        'builder': () => MedicamentoCetamina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Cetamina
      {
        'nome': MedicamentoBicarbonatoSodio.nome,
        'builder': () => MedicamentoBicarbonatoSodio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Bicarbonato de Sódio
      {
        'nome': MedicamentoCloretoCalcio.nome,
        'builder': () => MedicamentoCloretoCalcio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Cloreto de Cálcio
      {
        'nome': MedicamentoCloretoPotassio.nome,
        'builder': () => MedicamentoCloretoPotassio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Cloreto de Potássio
      {
        'nome': MedicamentoGluconatoCalcio.nome,
        'builder': () => MedicamentoGluconatoCalcio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Gluconato de Cálcio
      {
        'nome': MedicamentoSulfatoMagnesio.nome,
        'builder': () => MedicamentoSulfatoMagnesio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Sulfato de Magnésio
      {
        'nome': MedicamentoFurosemida.nome,
        'builder': () => MedicamentoFurosemida.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Furosemida
      {
        'nome': MedicamentoBumetanida.nome,
        'builder': () => MedicamentoBumetanida.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Bumetanida
      {
        'nome': MedicamentoTorasemida.nome,
        'builder': () => MedicamentoTorasemida.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Torasemida
      {
        'nome': MedicamentoManitol.nome,
        'builder': () => MedicamentoManitol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Manitol
      {
        'nome': MedicamentoGlicose50.nome,
        'builder': () => MedicamentoGlicose50.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Glicose 50%
      {
        'nome': MedicamentoInsulinaRegular.nome,
        'builder': () => MedicamentoInsulinaRegular.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Insulina Regular
      {
        'nome': MedicamentoBetametasona.nome,
        'builder': () => MedicamentoBetametasona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Betametasona
      {
        'nome': MedicamentoMetilprednisolona.nome,
        'builder': () => MedicamentoMetilprednisolona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Metilprednisolona
      {
        'nome': MedicamentoDexametasona.nome,
        'builder': () => MedicamentoDexametasona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dexametasona
      {
        'nome': MedicamentoHidrocortisona.nome,
        'builder': () => MedicamentoHidrocortisona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Hidrocortisona
      {
        'nome': MedicamentoSuccinilcolina.nome,
        'builder': () => MedicamentoSuccinilcolina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Succinilcolina
      {
        'nome': MedicamentoRocuronio.nome,
        'builder': () => MedicamentoRocuronio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Rocurônio
      {
        'nome': MedicamentoVecuronio.nome,
        'builder': () => MedicamentoVecuronio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Vecurônio
      {
        'nome': MedicamentoAtracurio.nome,
        'builder': () => MedicamentoAtracurio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Atracúrio
      {
        'nome': MedicamentoCisatracurio.nome,
        'builder': () => MedicamentoCisatracurio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Cisatracúrio
      {
        'nome': MedicamentoMivacurio.nome,
        'builder': () => MedicamentoMivacurio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Mivacúrio
      {
        'nome': MedicamentoPancuronio.nome,
        'builder': () => MedicamentoPancuronio.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Pancurônio
      {
        'nome': MedicamentoMidazolam.nome,
        'builder': () => MedicamentoMidazolam.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Midazolam
      {
        'nome': MedicamentoLorazepam.nome,
        'builder': () => MedicamentoLorazepam.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Lorazepam
      {
        'nome': MedicamentoDiazepam.nome,
        'builder': () => MedicamentoDiazepam.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Diazepam
      {
        'nome': MedicamentoFlumazenil.nome,
        'builder': () => MedicamentoFlumazenil.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Flumazenil
      {
        'nome': MedicamentoRemimazolam.nome,
        'builder': () => MedicamentoRemimazolam.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Remimazolam
      {
        'nome': MedicamentoDimenidrinato.nome,
        'builder': () => MedicamentoDimenidrinato.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dimenidrinato
      {
        'nome': MedicamentoHioscina.nome,
        'builder': () => MedicamentoHioscina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Hioscina
      {
        'nome': MedicamentoBromoprida.nome,
        'builder': () => MedicamentoBromoprida.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Bromoprida
      {
        'nome': MedicamentoMetoclopramida.nome,
        'builder': () => MedicamentoMetoclopramida.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Metoclopramida
      {
        'nome': MedicamentoDroperidol.nome,
        'builder': () => MedicamentoDroperidol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Droperidol
      {
        'nome': MedicamentoFenobarbital.nome,
        'builder': () => MedicamentoFenobarbital.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Fenobarbital
      {
        'nome': MedicamentoFenitoina.nome,
        'builder': () => MedicamentoFenitoina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Fenitoína
      {
        'nome': MedicamentoAcidoTranexamico.nome,
        'builder': () => MedicamentoAcidoTranexamico.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Ácido Tranexâmico
      {
        'nome': MedicamentoAcidoAminocaproico.nome,
        'builder': () => MedicamentoAcidoAminocaproico.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Ácido Aminocaproico
      {
        'nome': MedicamentoAlteplase.nome,
        'builder': () => MedicamentoAlteplase.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Alteplase
      {
        'nome': MedicamentoEnoxaparina.nome,
        'builder': () => MedicamentoEnoxaparina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Enoxaparina
      {
        'nome': MedicamentoHeparinaSodica.nome,
        'builder': () => MedicamentoHeparinaSodica.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Heparina Sódica
      {
        'nome': MedicamentoMetoprolol.nome,
        'builder': () => MedicamentoMetoprolol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Metoprolol
      {
        'nome': MedicamentoLidocaina.nome,
        'builder': () => MedicamentoLidocaina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Lidocaína
      {
        'nome': MedicamentoBupivacaina.nome,
        'builder': () => MedicamentoBupivacaina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Bupivacaína
      {
        'nome': MedicamentoRopivacaina.nome,
        'builder': () => MedicamentoRopivacaina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Ropivacaína
      {
        'nome': MedicamentoLidocainaAntiarritmica.nome,
        'builder': () => MedicamentoLidocainaAntiarritmica.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Lidocaína (Antiarrítmico)
      {
        'nome': MedicamentoSevoflurano.nome,
        'builder': () => MedicamentoSevoflurano.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Sevoflurano
      {
        'nome': MedicamentoDesflurano.nome,
        'builder': () => MedicamentoDesflurano.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Desflurano
      {
        'nome': MedicamentoIsoflurano.nome,
        'builder': () => MedicamentoIsoflurano.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Isoflurano
      {
        'nome': MedicamentoOxidoNitroso.nome,
        'builder': () => MedicamentoOxidoNitroso.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Óxido Nitroso
      {
        'nome': MedicamentoEnflurano.nome,
        'builder': () => MedicamentoEnflurano.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Enflurano (Descontinuado)
      {
        'nome': MedicamentoHalotano.nome,
        'builder': () => MedicamentoHalotano.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Halotano (Descontinuado)
      {
        'nome': MedicamentoOxidoNitrico.nome,
        'builder': () => MedicamentoOxidoNitrico.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Óxido Nítrico
      {
        'nome': MedicamentoParacetamol.nome,
        'builder': () => MedicamentoParacetamol.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Paracetamol
      {
        'nome': MedicamentoDipirona.nome,
        'builder': () => MedicamentoDipirona.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dipirona
      {
        'nome': MedicamentoClonidina.nome,
        'builder': () => MedicamentoClonidina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Clonidina
      {
        'nome': MedicamentoDexmedetomidina.nome,
        'builder': () => MedicamentoDexmedetomidina.buildCard(
          context,
          favoritos,
          _alternarFavorito,
        ),
      }, // Dexmedetomidina
      {
        'nome': 'Diclofenaco',
        'builder': () => Diclofenaco.buildCard(context),
      }, // Diclofenaco
      {
        'nome': 'Cetorolaco',
        'builder': () => Cetorolaco.buildCard(context),
      }, // Cetorolaco
      {
        'nome': 'Tenoxicam',
        'builder': () => Tenoxicam.buildCard(context),
      }, // Tenoxicam
      {
        'nome': 'Dexketoprofeno',
        'builder': () => Dexketoprofeno.buildCard(context),
      }, // Dexketoprofeno
      {
        'nome': 'Ibuprofeno',
        'builder': () => Ibuprofeno.buildCard(context),
      }, // Ibuprofeno
    ];
    final List<Map<String, dynamic>> medicamentosFiltrados = medicamentos.where((med) => med['nome'].toLowerCase().contains(_query)).toList();
    medicamentosFiltrados.sort((a, b) {
      final nomeA = a['nome'] as String;
      final nomeB = b['nome'] as String;
      final aFav = favoritos.contains(nomeA);
      final bFav = favoritos.contains(nomeB);
      if (aFav && !bFav) return -1;
      if (!aFav && bFav) return 1;
      return nomeA.compareTo(nomeB);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamentos'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'limpar_expansao') {
                _limparEstadosExpansao();
              } else if (value == 'reconstruir') {
                _forcarReconstrucao();
              } else if (value == 'verificar_estados') {
                _verificarEstados();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'limpar_expansao',
                child: Row(
                  children: [
                    Icon(Icons.unfold_less),
                    SizedBox(width: 8),
                    Text('Fechar todos os cards'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'reconstruir',
                child: Row(
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 8),
                    Text('Reconstruir cards'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'verificar_estados',
                child: Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(width: 8),
                    Text('Verificar estados'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Semantics(
                    label: 'Campo de busca de medicamentos ou condições',
                    child: TextField(
                      controller: _searchController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: medicamentosFiltrados.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nenhum medicamento encontrado.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Ajude-nos a melhorar:',
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: 'bhdaroz@gmail.com',
                            query: 'subject=Feedback sobre o app MC Emergency',
                          );
                          launchUrl(emailUri);
                        },
                        child: const Text(
                          'bhdaroz@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  key: const PageStorageKey<String>('medicamentos_list'),
                  itemCount: medicamentosFiltrados.length,
                  itemBuilder: (context, index) {
                    final med = medicamentosFiltrados[index];
                    try {
                      return KeyedSubtree(
                        key: ValueKey('med_${med['nome']}_$index'),
                        child: FutureBuilder<Widget>(
                          future: _buildMedicationCard(med),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Card(
                                child: ListTile(
                                  leading: CircularProgressIndicator(),
                                  title: Text('Carregando...'),
                                ),
                              );
                            }
                            
                            if (snapshot.hasError) {
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.error, color: Colors.red),
                                  title: Text('Erro: ${snapshot.error}'),
                                ),
                              );
                            }
                            
                            return snapshot.data ?? const SizedBox.shrink();
                          },
                        ),
                      );
                    } catch (e) {
                      print('Erro ao carregar ${med['nome']}: $e');
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.error, color: Colors.red),
                          title: Text('Erro ao carregar ${med['nome']}'),
                          subtitle: Text('$e'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
