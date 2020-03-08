<%-- 
    Document   : amortizacao-constante
    Created on : 08/03/2020, 02:13:45
    Author     : thifany_gomes
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SAC</title>
        
    </head>
    <body>
            <h1>Sistema de Amortização Constante</h1>
        <form>
            <label>Valor do Financiamento:</label><br>
            <input type="number" min="1" name="valorDivida"><br>
            <label>Parcelas:</label><br>
            <input type="number" name="periodo">
            <label>Taxa (a.m.):</label><br>
            <input type="number" name="taxa">
            <input type="submit" value="Calcular">
        </form>  
         
        <% try {
            double valorDivida = Double.parseDouble(request.getParameter("valorDivida"));
            int periodo = Integer.parseInt(request.getParameter("periodo"));
            double taxa = Double.parseDouble(request.getParameter("taxa"));
            NumberFormat nf = new DecimalFormat("#,##0.00");
            
            double prestacaoMensal = 0;
            double tPrestacaoMensal = 0;
            double saldoDevedor = valorDivida;
            //a amortização do sistema SAC é constante, por isso valor esta calculado antes do for
            double amortizacao = saldoDevedor/periodo;
            double tAmortizacao = amortizacao * periodo;
            //juros é calculado primeiro fora do for pois é feito com base no valor inicial da dívida
            double juros = saldoDevedor * (taxa/100);
            double totalJuros = 0;
        %>  
        <table>
            <tr>
                <th>Período</th>
                <th>Saldo Devedor</th>
                <th>Amortização</th>
                <th>Juros</th>
                <th>Prestações Mensais</th>
            </tr>
            <% for(int i=1; i<periodo; i++){
                //nesta linha é concatenado o juros anterior e depois soma com todos os juros calculados no loop
                totalJuros = totalJuros + juros;
                //a cada iteração o saldo devedor é subtraído o valor de amortização (que é constante)
                saldoDevedor = saldoDevedor - amortizacao;
                prestacaoMensal = amortizacao + juros;
                tPrestacaoMensal = tPrestacaoMensal + prestacaoMensal;
            %>
            <tr>
                <td><%= i++ %></td> <!-- representa o período conforme a iteração do for (o mês/parcela) -->
                <td><%= nf.format(saldoDevedor) %></td>
                <td><%= nf.format(amortizacao) %></td>
                <td><%= nf.format(juros) %></td>
                <td><%= nf.format(prestacaoMensal) %></td>
            <%  //ainda dentro do for a taxa de juros é calculada novamente em cima do novo valor de saldo devedor
                juros = saldoDevedor * (taxa/100);
                }
            %>
            </tr>
            
            <div>
                <%= "Total Amortização: R$ " + tAmortizacao %>
                <%= "Total de Juros: R$ " + totalJuros %>
                <%= "Total das Prestações: R$ " + tPrestacaoMensal %>
            </div>
            
            <% } catch (Exception ex){ %>
            <b>Dados incorretos!!<br> Digite os dados novamente!!</b>
            <% } %>
        </table>
        
    </body>
</html>

