import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'iniciofestafacil_model.dart';
export 'iniciofestafacil_model.dart';

/// Crie uma animação de introdução para o aplicativo "Festa Fácil Group" com
/// as seguintes características, Fundo escuro roxo (#1A0835 ou semelhante),
/// como na imagem fornecida Balão roxo com reflexo entra flutuando suavemente
/// do topo da tela em direção ao centro-esquerda, até parar **exatamente
/// acima da letra “F” de “Festa Confete de festa colorido** (nas cores
/// laranja, rosa, azul e amarelo, igual na imagem) está preso ao balão e
/// acompanha o movimento4.
///
/// Quando o balão para, o **confete explode com animação rápida**, mas **o
/// balão não estoura**5. Após a explosão, aparece **a logo "Festa Fácil
/// Group"** com a mesma tipografia e cores da imagem:   - "Festa" em rosa
/// "Fácil" em amarelo "Group" em branco A logo aparece com efeito de fade-in
/// aparecimento suave fixando-se no centro da tela Após a logo fixar, aparece
/// lentamente embaixo da frase:  O melhor aplicativo de festa do mundo" Com
/// fonte moderna, cor branca, centralizada
class IniciofestafacilWidget extends StatefulWidget {
  const IniciofestafacilWidget({super.key});

  static String routeName = 'iniciofestafacil';
  static String routePath = '/iniciofestafacil';

  @override
  State<IniciofestafacilWidget> createState() => _IniciofestafacilWidgetState();
}

class _IniciofestafacilWidgetState extends State<IniciofestafacilWidget> {
  late IniciofestafacilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IniciofestafacilModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.pushNamed(LoginWidget.routeName);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1A0835),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1A0835),
                      Color(0xFF2D1B69),
                      Color(0xFF1A0835)
                    ],
                    stops: [0.0, 0.5, 1.0],
                    begin: AlignmentDirectional(0.0, 1.0),
                    end: AlignmentDirectional(0, -1.0),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.3, -0.2),
                child: Lottie.asset(
                  'assets/jsons/<URL_omitted>',
                  width: 120.0,
                  height: 150.0,
                  fit: BoxFit.contain,
                  repeat: false,
                  animate: true,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Lottie.asset(
                  'assets/jsons/<URL_omitted>',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                  repeat: false,
                  animate: true,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFBA55D3), Color(0xFF8A2BE2)],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(1.0, 1.0),
                            end: AlignmentDirectional(-1.0, -1.0),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(-0.3, -0.4),
                          child: Container(
                            width: 20.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: Color(0x66FFFFFF),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Festa',
                              style: TextStyle(
                                color: Color(0xFFFF69B4),
                                fontWeight: FontWeight.bold,
                                fontSize: 42.0,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(),
                            ),
                            TextSpan(
                              text: 'Fácil',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontWeight: FontWeight.bold,
                                fontSize: 42.0,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(),
                            ),
                            TextSpan(
                              text: 'Group',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 42.0,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .displayLarge
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displayLarge
                                      .fontStyle,
                                ),
                                fontSize: 42.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .displayLarge
                                    .fontStyle,
                                lineHeight: 1.2,
                              ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.9,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            40.0, 24.0, 40.0, 0.0),
                        child: Text(
                          'O melhor aplicativo de festa do mundo',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.1, -0.3),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6347),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.1, -0.25),
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF00BFFF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.2, -0.1),
                child: Container(
                  width: 7.0,
                  height: 7.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD700),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.05, -0.15),
                child: Container(
                  width: 5.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF69B4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.35, -0.05),
                child: Container(
                  width: 9.0,
                  height: 9.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF32CD32),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.15, -0.08),
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF4500),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
